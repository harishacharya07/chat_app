import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) pickedImageFn;

  UserImagePicker(this.pickedImageFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _selectedImage;

  void _pickImage() async {
    final pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _selectedImage = pickedImage;
    });
    widget.pickedImageFn(_selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: _selectedImage == null ? null : FileImage(
            _selectedImage,
          ),
        ),
        TextButton(
          onPressed: _pickImage,
          child: Text('This is new flutter button'),
        ),
      ],
    );
  }
}
