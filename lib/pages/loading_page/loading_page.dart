import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Logo.png',
              scale: 3.5,
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              child: const LinearProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
