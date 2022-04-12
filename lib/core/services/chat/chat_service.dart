import 'package:whats_chat/core/models/chat_menssage/chat_message.dart';
import 'package:whats_chat/core/models/chat_user/chat_user.dart';
import 'chat_firebase_service.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage?> save(String text, ChatUser user);

  factory ChatService() {
    return ChatFirebaseService();
  }
}
