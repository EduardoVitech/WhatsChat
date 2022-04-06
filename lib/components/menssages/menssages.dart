import 'package:flutter/material.dart';
import 'package:whats_chat/components/menssage_bubble/menssage_bubble.dart';
import 'package:whats_chat/core/models/chat_menssage/chat_message.dart';
import 'package:whats_chat/core/services/auth/auth_service.dart';
import 'package:whats_chat/core/services/chat/chat_service.dart';

class Menssages extends StatelessWidget {
  const Menssages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              child: const LinearProgressIndicator(),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Opacity(
            opacity: 0.3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/NoMessage.png',
                    scale: 3.5,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'No Message!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (ctx, i) => MenssageBubble(
              key: ValueKey(msgs[i].id),
              message: msgs[i],
              belongsToCurrentUser: currentUser?.id == msgs[i].userId,
            ),
          );
        }
      },
    );
  }
}
