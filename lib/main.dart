import 'package:flutter/material.dart';
import 'pages/auth_page/auth_page.dart';

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
      home: const AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
