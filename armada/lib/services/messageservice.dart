// import 'dart:convert';

// // import 'package:flutter_socket_io/flutter_socket_io.dart';
// // import 'package:flutter_socket_io/socket_io_manager.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// import '../models/message.dart';

// class MessageService {
//   static const String _serverUrl = 'http://localhost:3000';
//   static const String _socketUrl = '$_serverUrl/chat';

//   final SocketIO socket = SocketIOManager().createSocketIO(_socketUrl, '/');
//   late SharedPreferences prefs;

//   MessageService() {
//     socket.onConnect((_) async {
//       prefs = await SharedPreferences.getInstance();
//       print('Socket connected.');

//       if (prefs.containsKey('userId')) {
//         socket.emit('authenticate', prefs.getString('userId'));
//       }
//     });

//     socket.onDisconnect((_) {
//       print('Socket disconnected.');
//     });
//   }

//   Future<List<Message>> getMessages(String userId) async {
//     final response = await Api.get('messages/$userId');

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonList = json.decode(response.body);
//       return jsonList.map((json) => Message.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load messages.');
//     }
//   }

//   Future<void> sendMessage(Message message) async {
//     await Api.post('messages', message.toJson());
//     socket.emit('new-message',
//         {'senderId': message.senderId, 'receiverId': message.receiverId});
//   }

//   void dispose() {
//     socket.disconnect();
//   }
// }
