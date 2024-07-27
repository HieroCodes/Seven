import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leboncoin/screens/conversation.dart';
import 'package:leboncoin/screens/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
      return MaterialApp(
      title: 'Leboncoin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orangeAccent,
          foregroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const DashboardScreen(),
      routes: {
        '/home': (context) => const DashboardScreen(),
      },
    );
  }
}