import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      widget.onImagePick(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.shade400,
          backgroundImage: _image != null ? FileImage(_image!) : null,
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
