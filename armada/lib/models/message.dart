class Message {
  final String sender;
  final String receiver;
  final String content;
  final DateTime timestamp;
  final String status;

  Message({
    required this.sender,
    required this.receiver,
    required this.content,
    required this.timestamp,
    required this.status,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json['senderId'],
      receiver: json['recipientId'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      status: json['status'],
    );
  }
}
