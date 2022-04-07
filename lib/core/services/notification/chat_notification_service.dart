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
}
