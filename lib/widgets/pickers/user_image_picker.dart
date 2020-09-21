import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File image) onImageSelected;

  const UserImagePicker({Key key, this.onImageSelected}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImageFile;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 50,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage.path);

    widget.onImageSelected(pickedImageFile);

    setState(() {
      _pickedImageFile = pickedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 50.0,
          backgroundImage: _pickedImageFile != null
              ? FileImage(
                  _pickedImageFile,
                )
              : null,
          child: _pickedImageFile == null
              ? Icon(
                  Icons.account_circle,
                  color: Colors.white54,
                  size: 48.0,
                )
              : null,
        ),
        Positioned(
          bottom: -5.0,
          right: -10.0,
          child: Container(
            child: IconButton(
              icon: Icon(
                Icons.camera_alt,
              ),
              onPressed: _pickImage,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(40.0),
              ),
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}
