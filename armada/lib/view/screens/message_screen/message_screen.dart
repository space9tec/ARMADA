// import 'dart:convert';
// import 'package:armada/view/screens/message_screen/chat_screen.dart';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';

// class UserListPage extends StatefulWidget {
//   final String farmerId;

//   UserListPage({required this.farmerId});

//   @override
//   _UserListPageState createState() => _UserListPageState();
// }

// class _UserListPageState extends State<UserListPage> {
//   List<String> _users = [];

//   @override
//   void initState() {
//     super.initState();
//     // Call API endpoint to retrieve user list
//     _getUsers();
//   }

//   void _getUsers() async {
//     // Call Node.js API endpoint to retrieve user list
//     final response = await http.get(Uri.parse(
//         'http://your-node-app-url.com/users?farmerId=${widget.farmerId}'));

//     if (response.statusCode == 200) {
//       setState(() {
//         // Update the UI with the retrieved user list
//         _users = List<String>.from(json.decode(response.body));
//       });
//     } else {
//       print('Failed to retrieve user list');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Users')),
//       body: ListView.builder(
//         itemCount: _users.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(_users[index]),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ChatPage(
//                     farmerId: widget.farmerId,
//                     receiverId: _users[index],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
