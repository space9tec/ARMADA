import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

import '../../../models/model.dart';
import '../../../networkhandler.dart';
import '../../../services/socket_service.dart';

class ChatPage extends StatefulWidget {
  final String? receiver;
  // final String name;
  final String sender;
  final SocketService socketService;

  const ChatPage({
    Key? key,
    required this.receiver,
    required this.sender,
    required this.socketService,
    // required this.name,
  }) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Message> messages = [];
  final ScrollController _controller = ScrollController();
  NetworkHandler networkHandler = NetworkHandler();

  String getTimeFromDateTime(DateTime dateTime) {
    String time = DateFormat("HH:mm").format(dateTime);
    return time;
  }

  @override
  void initState() {
    super.initState();

    // Fetch initial messages
    fetchData().then((_) {
      // Initialize socket and listen for incoming message events
      widget.socketService.initSocket(widget.sender);
      widget.socketService.socket!.on('message', (data) {
        if (mounted) {
          setState(() {
            addMessage(data);
            SchedulerBinding.instance
                .addPostFrameCallback((_) => _controller.animateTo(
                      _controller.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    ));
          });
        }
      });
    });
    // SchedulerBinding.instance.addPostFrameCallback((_) => _controller.animateTo(
    //       _controller.position.maxScrollExtent,
    //       duration: const Duration(milliseconds: 300),
    //       curve: Curves.easeOut,
    //     ));
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Scroll to the end of the chat messages
    //   _controller.jumpTo(_controller.position.maxScrollExtent);
    // });
  }

  void addMessage(data) {
    setState(() {
      messages.add(Message.fromJson(data));
    });
  }

  @override
  void dispose() {
    widget.socketService.socket!.off('message');
    widget.socketService.closeConnection();
    super.dispose();
  }

  UserModel reciver = UserModel(
      firstname: "",
      lastname: "",
      useid: "",
      phone: "",
      password: "",
      image: "");
  Future<void> fetchData() async {
    try {
      final response = await networkHandler.get(
          "/api/message/fetch-messages/${widget.sender}/${widget.receiver}");

      Map<String, dynamic> output = json.decode(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        print("from call");
        Map<String, dynamic> reciverData;

        setState(() {
          messages = List<Message>.from(
              data['messages'].map((message) => Message.fromJson(message)));
          reciverData = output['reciever'];
          reciver = UserModel.fromJson(reciverData);
        });
        print("from call2");
        print(messages);
        // Log the fetched data
        print(data);
      } else {
        throw Exception('Failed to fetch messages');
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(reciver.firstname),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.fast),
              controller: _controller,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];
                // print(messages);
                bool isMe = message.sender == widget.sender;
                // Only show messages that were sent/received by the current user
                if (isMe || message.sender == widget.receiver) {
                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 9, horizontal: 18),
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                          color: isMe
                              ? const Color.fromARGB(255, 48, 180, 77)
                                  .withOpacity(0.4)
                              : Colors.grey.withOpacity(0.4),
                          // borderRadius: BorderRadius.circular(16),
                          // border: isMe? BorderDirectional(bottom: BorderSide())
                          borderRadius: isMe
                              ? const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10))
                              : const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.content,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            getTimeFromDateTime(message.timestamp),
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      // Text(message.content),
                    ),
                  );
                } else {
                  // Return an empty container if the message was not sent/received by the current user
                  return Container();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _messageController,
                    decoration:
                        const InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _sendMessage() async {
    print(messages);
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      try {
        final response =
            await networkHandler.postt("/api/message/send-message", {
          'sender': widget.sender,
          'receiver': widget.receiver!,
          'content': message,
        });
        if (response.statusCode == 201) {
          final data = jsonDecode(response.body);
          setState(() {
            messages.add(Message.fromJson(data['message']));
          });
          _messageController.clear();
          SchedulerBinding.instance.addPostFrameCallback((_) =>
              _controller.animateTo(_controller.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut));
          print(messages);
          // widget.socketService.socket!.emit('message', data['message']);
        } else {
          print(response.body);
          throw Exception('Failed to send message');
        }
      } catch (error) {
        print(error.toString());
      }
    }
  }
}
