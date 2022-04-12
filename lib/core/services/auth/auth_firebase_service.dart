import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:whats_chat/core/models/chat_user/chat_user.dart';
import 'package:whats_chat/core/services/auth/auth_service.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;
  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
  });

  ChatUser? get currentUser {
    return _currentUser;
  }

  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  Future<void> signup(
      String name, String email, String password, File? image) async {
    final auth = FirebaseAuth.instance;
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) return;

    // 1. Upload da foto do usuario
    final imageName = '${credential.user!.uid}.png';
    final imageURL = await _uploadUserImage(image, imageName);

    print(imageURL);

    // 2. Atualizar os atriutos do usuario
    await credential.user?.updateDisplayName(name);
    await credential.user?.updatePhotoURL(imageURL);

    // 3. Salvar usuário no banco de dados
    await _saveChatUser(_toChatUser(credential.user!, imageURL));
  }

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);
    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    return docRef.set({
      'name': user.name,
      'email': user.email,
      'imageURL': user.imageURL,
    });
  }

  static ChatUser _toChatUser(User user, [String? imageURL]) {
    return ChatUser(
      id: user.uid,
      //Utiliza o nome antes do @ caso não tenha nome
      name: user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageURL: imageURL ?? user.photoURL ?? 'assets/images/ImageUserNull.png',
    );
  }
}
