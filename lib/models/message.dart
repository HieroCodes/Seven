class Message {
  final int id;
  final int conversationId;
  final int authorId;
  final int timestamp;
  final String body;

  Message({
    required this.id,
    required this.conversationId,
    required this.authorId,
    required this.timestamp,
    required this.body,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      conversationId: json['conversationId'],
      authorId: json['authorId'],
      timestamp: json['timestamp'],
      body: json['body'],
    );
  }
}
