import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_chat/core/services/notification/chat_notification_service.dart';
import 'package:whats_chat/pages/auth_page/auth_page.dart';
import 'package:whats_chat/pages/chat_page/chat_page.dart';
import 'package:whats_chat/pages/loading_page/loading_page.dart';
import '../../core/models/chat_user/chat_user.dart';
import '../../core/services/auth/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({Key? key}) : super(key: key);

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
    await Provider.of<ChatNotificationService>(
      context,
      listen: false,
    ).init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        } else {
          return StreamBuilder<ChatUser?>(
            stream: AuthService().userChanges,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingPage();
              } else {
                return snapshot.hasData ? const ChatPage() : const AuthPage();
              }
            },
          );
        }
      },
    );
  }
}
