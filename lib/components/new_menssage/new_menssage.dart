import 'package:flutter/material.dart';
import 'package:whats_chat/core/services/auth/auth_service.dart';
import 'package:whats_chat/core/services/chat/chat_service.dart';

class NewMenssage extends StatefulWidget {
  const NewMenssage({Key? key}) : super(key: key);

  @override
  State<NewMenssage> createState() => _NewMenssageState();
}

class _NewMenssageState extends State<NewMenssage> {
  String _enteredMessage = '';
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      await ChatService().save(_enteredMessage, user);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            onChanged: (msg) => setState(() => _enteredMessage = msg),
            decoration: const InputDecoration(
              labelText: 'Enviar menssagem...',
            ),
            onSubmitted: (_) {
              if (_enteredMessage.trim().isNotEmpty) {
                _sendMessage();
              }
            },
          ),
        ),
        IconButton(
          onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          icon: const Icon(
            Icons.send_rounded,
          ),
        ),
      ],
    );
  }
}
