class Message {
  String senderId;
  String recipientId;
  String content;
  DateTime timestamp;

  Message(
      {required this.senderId,
      required this.recipientId,
      required this.content,
      required this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      recipientId: json['recipientId'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['senderId'] = this.senderId;
    data['recipientId'] = this.recipientId;
    data['content'] = this.content;
    data['timestamp'] = this.timestamp.toIso8601String();
    return data;
  }
}
