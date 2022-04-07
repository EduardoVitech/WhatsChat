import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_chat/core/services/notification/chat_notification_service.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Notifications'),
        ),
      ),
      body: Provider.of<ChatNotificationService>(context).itemsCount == 0
          ? Opacity(
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
                      'No Notification!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: service.itemsCount,
              itemBuilder: (ctx, i) => ListTile(
                title: Text(items[i].title),
                subtitle: Text(items[i].body),
                onTap: () => service.remove(i),
              ),
            ),
    );
  }
}
