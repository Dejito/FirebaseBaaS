import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {

  final void Function (File img) pickImageFn;

  const UserImagePicker({super.key, required this.pickImageFn});

  @override
  UserImagePickerState createState() => UserImagePickerState();
}

class UserImagePickerState extends State<UserImagePicker> {

  File? _pickedImage;
  final _imagePicker = ImagePicker();

  void _pickImage() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    print('picked image is >>>>>> $_pickedImage');
    setState(() {
      _pickedImage = File(pickedImage!.path);
    });
    widget.pickImageFn(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text('Add Image'),
        ),
      ],
    );
  }
}
