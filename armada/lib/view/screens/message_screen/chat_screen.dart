// import 'dart:convert';

// import 'package:armada/models/message.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// // class ChatPage extends StatefulWidget {
// //   final String farmerId;
// //   final String receiverId;

// //   ChatPage({required this.farmerId, required this.receiverId});

// //   @override
// //   _ChatPageState createState() => _ChatPageState();
// // }

// // class _ChatPageState extends State<ChatPage> {
// //   List<Message> _messages = [];

// //   final TextEditingController _controller = TextEditingController();

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Call API endpoint to retrieve chat history
// //     _getMessages();
// //   }

// //   void _getMessages() async {
// //     // Call Node.js API endpoint to retrieve chat history
// //     final response = await http.get(Uri.parse(
// //         'http://your-node-app-url.com/messages?farmerId=${widget.farmerId}&receiverId=${widget.receiverId}'));

// //     if (response.statusCode == 200) {
// //       setState(() {
// //         // Update the UI with the retrieved chat history
// //         _messages = List<Message>.from(
// //             json.decode(response.body).map((model) => Message.fromJson(model)));
// //       });
// //     } else {
// //       print('Failed to retrieve chat history');
// //     }
// //   }

// //   void _sendMessage() async {
// //     // Call Node.js API endpoint to send message
// //     final response =
// //         await http.post(Uri.parse('http://your-node-app-url.com/messages'),
// //             headers: {'content-type': 'application/json'},
// //             body: json.encode({
// //               'sender': widget.farmerId,
// //               'receiver': widget.receiverId,
// //               'content': _controller.text,
// //             }));

// //     if (response.statusCode == 201) {
// //       setState(() {
// //         // Add the sent message to the chat history
// //         // _messages.add(Message(
// //         //   sender: widget.farmerId,
// //         //   receiver: widget.receiverId,
// //         //   content: _controller.text,
// //         //   timestamp: DateTime.now(),
// //         // ));
// //         // Clear the text input field
// //         _controller.clear();
// //       });
// //     } else {
// //       print('Failed to send message');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text(widget.receiverId)),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: _messages.length,
// //               itemBuilder: (context, index) {
// //                 final message = _messages[index];
// //                 // Determine whether to align the message to the left or right based on the sender and receiver
// //                 final alignment = message.senderId == widget.farmerId
// //                     ? Alignment.centerRight
// //                     : Alignment.centerLeft;
// //                 return Container(
// //                   alignment: alignment,
// //                   child: Text(message.content),
// //                 );
// //               },
// //             ),
// //           ),
// //           Padding(
// //             padding: EdgeInsets.all(8.0),
// //             child: Row(
// //               children: [
// //                 Expanded(
// //                   child: TextField(
// //                     controller: _controller,
// //                     decoration: InputDecoration(hintText: 'Type a message...'),
// //                     onSubmitted: (value) {
// //                       _sendMessage();
// //                     },
// //                   ),
// //                 ),
// //                 IconButton(
// //                   icon: Icon(Icons.send),
// //                   onPressed: () {
// //                     _sendMessage();
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// class ChatScreen extends StatefulWidget {
//   final String receiverId;
//   final String receiverName;

//   ChatScreen({required this.receiverId, required this.receiverName});

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final MessageService _messageService = MessageService();
//   late String _userId;
//   List<Message> _messages = [];

//   @override
//   void initState() {
//     super.initState();

//     SharedPreferences.getInstance().then((prefs) {
//       setState(() {
//         _userId = prefs.getString('userId')!;
//       });

//       _messageService.socket.on('new-message', (_) {
//         _loadMessages();
//       });
//     });

//     _loadMessages();
//   }

//   Future<void> _loadMessages() async {
//     final messages = await _messageService.getMessages(_userId);
//     setState(() {
//       _messages = messages
//           .where((m) =>
//               m.senderId == widget.receiverId ||
//               m.receiverId == widget.receiverId)
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.receiverName),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(8.0),
//               itemCount: _messages.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final message = _messages[index];
//                 return Align(
//                   alignment: message.senderId == _userId
//                       ? Alignment.centerRight
//                       : Alignment.centerLeft,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: message.senderId == _userId
//                           ? Theme.of(context).accentColor
//                           : Colors.grey[200],
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     margin: EdgeInsets.symmetric(vertical: 4.0),
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                     child:
//                         Text(message.message, style: TextStyle(fontSize: 16.0)),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Type your message...',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     // final message = Message(
//                     //   senderId: _userId,
//                     //   receiverId: widget.receiverId,
//                     //   message: _messageController.text,
//                     //   createdAt: DateTime.now(),
//                     // );
//                     // _messageService.sendMessage(message);
//                     setState(() {
//                       // _messages.add(message);
//                       _messageController.clear();
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _messageService.dispose();
//     super.dispose();
//   }
// }
