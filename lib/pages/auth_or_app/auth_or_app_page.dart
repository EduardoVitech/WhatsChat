import 'package:flutter/material.dart';
import 'package:whats_chat/pages/auth_page/auth_page.dart';
import 'package:whats_chat/pages/chat_page/chat_page.dart';
import 'package:whats_chat/pages/loading_page/loading_page.dart';
import '../../core/models/chat_user/chat_user.dart';
import '../../core/services/auth/auth_service.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthService().userChanges,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          } else {
            return snapshot.hasData ? ChatPage() : AuthPage();
          }
        },
      ),
    );
  }
}
