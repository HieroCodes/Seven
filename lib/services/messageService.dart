import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message.dart';

class MessageService {
  final String apiUrl = 'http://192.168.1.28:3000/messages';

  Future<List<Message>> fetchMessages(int conversationId) async {
    final response = await http.get(Uri.parse('$apiUrl?conversationId=$conversationId'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Message.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<void> sendMessage(int conversationId, int authorId, String body) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'conversationId': conversationId,
        'authorId': authorId,
        'timestamp': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'body': body,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to send message');
    }
  }
}
