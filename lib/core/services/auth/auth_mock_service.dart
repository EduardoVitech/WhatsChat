import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:whats_chat/core/models/chat_user/chat_user.dart';
import 'package:whats_chat/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static final _defaultUser = ChatUser(
    id: '123',
    name: 'Testando Pessoa',
    email: 'testandoPessoa@teste.com',
    imageURL: 'assets/images/ImageUserNull.png',
  );

  static Map<String, ChatUser> _users = {
    _defaultUser.email: _defaultUser,
  };
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });

  ChatUser? get currentUser {
    return _currentUser;
  }

  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageURL: image?.path ?? 'assets/images/ImageUserNull.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  Future<void> logout() async {
    _updateUser(null);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
