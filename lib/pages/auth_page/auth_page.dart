import 'package:flutter/material.dart';
import 'package:whats_chat/components/auth_form/auth_form.dart';
import 'package:whats_chat/models/auth_form_data/auth_form_data.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  void _handleSubmit(AuthFormData formData) {
    setState(() => _isLoading = true);

    print('AuthPAge...');
    print(formData.email);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: _handleSubmit),
            ),
          ),
          if (_isLoading)
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2,
                  child: const LinearProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
