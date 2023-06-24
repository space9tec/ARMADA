import 'dart:convert';

// import 'package:chararmada/model/message.dart';
// import 'package:flutter/material.dart';
// import 'networkhandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../models/message.dart';
import '../../../networkhandler.dart';
import '../../../services/socket_service.dart';

class ChatPage extends StatefulWidget {
  final String receiver;
  final String name;
  final String sender;
  final SocketService socketService;

  ChatPage({
    Key? key,
    required this.receiver,
    required this.sender,
    required this.socketService,
    required this.name,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Message> messages = [];
  final ScrollController _controller = ScrollController();
  NetworkHandler networkHandler = NetworkHandler();

  @override
  void initState() {
    super.initState();

    // Fetch initial messages
    fetchData().then((_) {
      // Initialize socket and listen for incoming message events
      widget.socketService.initSocket(widget.sender);
      widget.socketService.socket.on('message', (data) {
        if (mounted) {
          setState(() {
            addMessage(data);
            SchedulerBinding.instance
                .addPostFrameCallback((_) => _controller.animateTo(
                      _controller.position.maxScrollExtent,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    ));
          });
        }
      });
    });
  }

  void addMessage(data) {
    setState(() {
      messages.add(Message.fromJson(data));
    });
  }

  @override
  void dispose() {
    widget.socketService.socket.off('message');
    widget.socketService.closeConnection();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final response = await networkHandler
          .get("/fetch-messages/${widget.sender}/${widget.receiver}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          messages = List<Message>.from(
              data['messages'].map((message) => Message.fromJson(message)));
        });
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
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];
                bool isMe = message.sender == widget.sender;
                // Only show messages that were sent/received by the current user
                if (isMe || message.sender == widget.receiver) {
                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: isMe
                            ? Color.fromARGB(255, 48, 180, 77).withOpacity(0.4)
                            : Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(message.content),
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
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
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
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      try {
        final response = await networkHandler.postt("/send-message", {
          'sender': widget.sender,
          'receiver': widget.receiver,
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
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOut));
        } else {
          throw Exception('Failed to send message');
        }
      } catch (error) {
        print(error.toString());
      }
    }
  }
}
