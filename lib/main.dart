import 'package:flutter/material.dart';
import 'package:whats_chat/pages/auth_or_app/auth_or_app_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsChat',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AuthOrAppPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
