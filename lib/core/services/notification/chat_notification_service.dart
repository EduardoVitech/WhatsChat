import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:whats_chat/core/models/chat_notification/chat_notification.dart';

class ChatNotificationService with ChangeNotifier {
  List<ChatNotification> _items = [];

  int get itemsCount {
    return _items.length;
  }

  List<ChatNotification> get items {
    return [..._items];
  }

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.remove(i);
    notifyListeners();
  }

  // Push Notification
  Future<void> init() async {
    await _configureForeground();
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen((msg) {
        if (msg.notification == null) return;
        add(ChatNotification(
          title: msg.notification!.title ?? 'Não informado',
          body: msg.notification!.body ?? 'Não informado',
        ));
      });
    }
  }
}
