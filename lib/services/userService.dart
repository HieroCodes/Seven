import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message.dart';
import '../models/user.dart';

class UserService {
  final String apiUrl = 'http://192.168.1.28:3000';

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$apiUrl/users'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => User.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<String> fetchLastMessage(int userId) async {
    final response = await http.get(Uri.parse('$apiUrl/conversations?senderId=$userId'));

    if (response.statusCode == 200) {
      List conversations = json.decode(response.body);
      List relevantConversations = conversations.where((conversation) =>
      conversation['senderId'] == userId || conversation['recipientId'] == userId).toList();

      if (relevantConversations.isNotEmpty) {
        final messagesResponse = await http.get(Uri.parse('$apiUrl/messages'));
        if (messagesResponse.statusCode == 200) {
          List messagesJson = json.decode(messagesResponse.body);
          List userMessages = messagesJson.where((message) =>
              relevantConversations.any((conversation) => conversation['id'] == message['conversationId'])).toList();

          if (userMessages.isNotEmpty) {
            userMessages.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
            final lastMessage = Message.fromJson(userMessages.first);
            return lastMessage.body;
          }
        }
      }
    }
    return 'Aucun message';
  }

}
