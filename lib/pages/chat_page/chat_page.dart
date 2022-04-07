import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_chat/components/menssages/menssages.dart';
import 'package:whats_chat/components/new_menssage/new_menssage.dart';
import 'package:whats_chat/core/services/auth/auth_service.dart';
import 'package:whats_chat/pages/notification_page/notification_page.dart';

import '../../core/services/notification/chat_notification_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('WhatsChat'),
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black87,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Sair'),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return const NotificationPage();
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.notifications,
                ),
              ),
              Provider.of<ChatNotificationService>(context).itemsCount == 0
                  ? Container()
                  : Positioned(
                      top: 5,
                      right: 5,
                      child: CircleAvatar(
                        maxRadius: 10,
                        backgroundColor: Colors.red.shade800,
                        child: Text(
                          '${Provider.of<ChatNotificationService>(context).itemsCount}',
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: const [
            Expanded(child: Menssages()),
            NewMenssage(),
          ],
        ),
      ),
    );
  }
}
