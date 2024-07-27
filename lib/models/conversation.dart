class Conversation {
  final int id;
  final int recipientId;
  final String recipientNickname;
  final int senderId;
  final String senderNickname;
  final int lastMessageTimestamp;

  Conversation({
    required this.id,
    required this.recipientId,
    required this.recipientNickname,
    required this.senderId,
    required this.senderNickname,
    required this.lastMessageTimestamp,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'],
      recipientId: json['recipientId'],
      recipientNickname: json['recipientNickname'],
      senderId: json['senderId'],
      senderNickname: json['senderNickname'],
      lastMessageTimestamp: json['lastMessageTimestamp'],
    );
  }
}
