import 'dart:async';
import 'dart:math';

import 'package:whats_chat/core/models/chat_menssage/chat_message.dart';
import 'package:whats_chat/core/models/chat_user/chat_user.dart';
import 'package:whats_chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [];

  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageURL,
    );

    _msgs.add(newMessage);
    _controller?.add(_msgs.reversed.toList());
    return newMessage;
  }
}
