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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 14,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              onChanged: (msg) => setState(() => _enteredMessage = msg),
              decoration: const InputDecoration(
                labelText: 'Enviar menssagem...',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 2.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black54,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            maxRadius: 25,
            child: IconButton(
              alignment: Alignment.center,
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
