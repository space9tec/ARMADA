// import 'package:armada/models/message.dart';

// class Conversation {
//   String id;
//   String farmerId;
//   String machineryOwnerId;
//   List<Message> messages;

//   Conversation(
//       {required this.id,
//       required this.farmerId,
//       required this.machineryOwnerId,
//       required this.messages});

//   factory Conversation.fromJson(Map<String, dynamic> json) {
//     return Conversation(
//       id: json['_id'],
//       farmerId: json['farmerId'],
//       machineryOwnerId: json['machineryOwnerId'],
//       messages: json['messages'] != null
//           ? (json['messages'] as List).map((i) => Message.fromJson(i)).toList()
//           : [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.id;
//     data['farmerId'] = this.farmerId;
//     data['machineryOwnerId'] = this.machineryOwnerId;
//     data['messages'] =
//         this.messages.map((message) => message.toJson()).toList();
//     return data;
//   }
// }
