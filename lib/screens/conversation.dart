import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/message.dart';
import '../services/messageService.dart';

class ConversationScreen extends StatefulWidget {
  final int conversationId;
  final String userNickname;

  const ConversationScreen({Key? key, required this.conversationId, required this.userNickname}) : super(key: key);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late Future<List<Message>> futureMessages;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureMessages = MessageService().fetchMessages(widget.conversationId);
  }

  void _sendMessage() async {
    final message = _controller.text;
    if (message.isNotEmpty) {
      try {
        await MessageService().sendMessage(widget.conversationId, 1, message);
        _controller.clear();
        setState(() {
          futureMessages = MessageService().fetchMessages(widget.conversationId);
        });
      } catch (e) {
        // Afficher une alerte ou un message d'erreur si l'envoi échoue
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send message: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userNickname,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<List<Message>>(
        future: futureMessages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun message trouvé'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final message = snapshot.data![index];
                final bool isCurrentUser = message.authorId == 1;
                final alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
                final color = isCurrentUser ? Colors.blue : Colors.grey.shade200;
                final textColor = isCurrentUser ? Colors.white : Colors.black;
                final time = DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(message.timestamp * 1000));

                return Align(
                  alignment: alignment,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.body,
                          style: TextStyle(color: textColor),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            time,
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
