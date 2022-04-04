import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whats_chat/others/image_null/image_null.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File image) onImagePick;

  const UserImagePicker({
    Key? key,
    required this.onImagePick,
  }) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _image;

  void _pickImage() {
    final picker = ImagePicker();
    picker.pickImage(
      source: ImageSource.gallery,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.transparent,
          backgroundImage: _image != null ? FileImage(_image!) : null,
          child: const ImageNull(),
        ),
        Container(
          height: 95,
          width: 100,
          alignment: Alignment.bottomRight,
          child: IconButton(
            onPressed: _pickImage,
            icon: const Icon(
              Icons.add_a_photo,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}
