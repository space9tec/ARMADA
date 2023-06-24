// import 'package:armada/models/conversation.dart';
// import 'package:armada/models/message.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';

// class ConversationService {
//   static const baseUrl = 'http://your-node-server-url.com/api';

//   static Future<List<Conversation>> getConversations(String farmerId) async {
//     Uri url = Uri.parse('/conversations/farmer/$farmerId');

//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final conversationsJson = json.decode(response.body) as List<dynamic>;
//       return conversationsJson
//           .map((json) => Conversation.fromJson(json))
//           .toList();
//     } else {
//       throw Exception('Failed to load conversations');
//     }
//   }

//   static Future<Conversation> createConversation(
//       String farmerId, String machineryOwnerId) async {
//     Uri url = Uri.parse('/conversations');

//     // final response = await http.get(url);
//     final response = await http.post(url,
//         body: {'farmerId': farmerId, 'machineryOwnerId': machineryOwnerId});
//     if (response.statusCode == 201) {
//       final conversationJson = json.decode(response.body);
//       return Conversation.fromJson(conversationJson);
//     } else {
//       throw Exception('Failed to create conversation');
//     }
//   }

//   static Future<Message> sendMessage(String conversationId, String senderId,
//       String recipientId, String content) async {
//     final timestamp =
//         DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(DateTime.now());
//     Uri url = Uri.parse('/messages');
//     final response = await http.post(url, body: {
//       'conversationId': conversationId,
//       'senderId': senderId,
//       'recipientId': recipientId,
//       'content': content,
//       'timestamp': timestamp
//     });
//     if (response.statusCode == 201) {
//       final messageJson = json.decode(response.body);
//       return Message.fromJson(messageJson);
//     } else {
//       throw Exception('Failed to send message');
//     }
//   }

//   String formater(String url) {
//     return baseUrl + url;
//   }
// }
