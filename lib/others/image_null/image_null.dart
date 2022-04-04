import 'package:flutter/material.dart';

class ImageNull extends StatelessWidget {
  const ImageNull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        'assets/image/nullUser.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
