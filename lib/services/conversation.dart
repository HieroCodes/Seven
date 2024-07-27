import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/conversation.dart';

class ConversationService {
  final String apiUrl = 'http://192.168.1.28:3000/conversations';

  Future<List<Conversation>> fetchConversations() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Conversation.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load conversations');
    }
  }
}
