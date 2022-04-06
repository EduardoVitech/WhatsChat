import 'dart:io';
import 'package:flutter/material.dart';
import 'package:whats_chat/core/models/chat_menssage/chat_message.dart';

class MenssageBubble extends StatelessWidget {
  static const _noImage = 'assets/images/ImageUserNull.png';
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MenssageBubble({
    Key? key,
    required this.message,
    required this.belongsToCurrentUser,
  }) : super(key: key);

  Widget _showUserImage(String imageURL) {
    ImageProvider? provider;
    final uri = Uri.parse(imageURL);

    if (uri.path.contains(_noImage)) {
      provider = const AssetImage(_noImage);
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(40),
        color: Colors.pink,
      ),
      child: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.white,
        backgroundImage: provider,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: belongsToCurrentUser
                    ? Colors.grey.shade300
                    : Colors.greenAccent.shade400,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: belongsToCurrentUser
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomRight: belongsToCurrentUser
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              width: 200,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment: belongsToCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.userName,
                    style: TextStyle(
                      color: belongsToCurrentUser ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    message.text,
                    textAlign:
                        belongsToCurrentUser ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                      color: belongsToCurrentUser ? Colors.black : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser ? null : 190,
          right: belongsToCurrentUser ? 190 : null,
          child: _showUserImage(message.userImageURL),
        ),
      ],
    );
  }
}
