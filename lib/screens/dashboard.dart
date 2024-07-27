import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/userService.dart';
import 'dart:math';
import 'conversation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<List<User>> futureUsers;
  final Map<int, Future<String>> lastMessages = {};

  @override
  void initState() {
    super.initState();
    futureUsers = UserService().fetchUsers();
  }

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff) ? myString : '${myString.substring(0, cutoff)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leboncoin',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('Aucun utilisateur trouvé');
            } else {
              final users = snapshot.data!;
              for (var user in users) {
                lastMessages[user.id] = UserService().fetchLastMessage(user.id);
              }

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final color = getRandomColor();

                  return FutureBuilder<String>(
                    future: lastMessages[user.id],
                    builder: (context, lastMessageSnapshot) {
                      if (lastMessageSnapshot.connectionState == ConnectionState.waiting) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: color,
                            child: Text(
                              user.nickname[0].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          title: Text(user.nickname),
                          subtitle: const Text('Chargement...'),
                        );
                      } else if (lastMessageSnapshot.hasError) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: color,
                            child: Text(
                              user.nickname[0].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          title: Text(user.nickname),
                          subtitle: const Text('Erreur de chargement'),
                        );
                      } else {
                        final lastMessage = lastMessageSnapshot.data!;
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: color,
                            child: Text(
                              user.nickname[0].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          title: Text(user.nickname),
                          subtitle: Text(truncateWithEllipsis(20, lastMessage)),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '13:31',
                                style: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              if (true) // Remplacer par la condition pour les messages non lus
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '3', // Remplacer par le nombre de messages non lus
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConversationScreen(
                                  conversationId: user.id,
                                  userNickname: user.nickname,
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
