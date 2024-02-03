// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../components/Photoviewer.dart';
import '../components/viewProfileTextfield.dart';
import '../components/Button.dart';
import '../components/NotificationBellIcon.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _imageFile;
  final imageUrl = 'https://picsum.photos/250?image=9';

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<String?> _uploadImage() async {
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          _imageFile!.path,
          filename: "upload_image",
        ),
      });
      Response response =
          await dio.post("https://your-server/upload_image", data: formData);
      return response.data['imageUrl'];
    } catch (error) {
      debugPrint("Error uploading image: $error");
      return null;
    }
  }

  Future<void> onSave() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        actions: <Widget>[
    NotificationBellIcon(),
  ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                _imageFile != null
                    ? Image.file(
                        _imageFile!,
                        width: double.infinity,
                        height: 200.0,
                        fit: BoxFit.cover,
                      )
                    : EllipseImageFromDatabase(imageUrl: imageUrl),
                Positioned(
                  bottom: 16.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Choose an option"),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  await _pickImage(ImageSource.gallery);
                                  Navigator.of(context).pop();
                                },
                                child: Text("Gallery"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await _pickImage(ImageSource.camera);
                                  Navigator.of(context).pop();
                                },
                                child: Text("Camera"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Icon(Icons.camera_alt),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ViewTextField(labelText: "Full Name", bottomMargin: 10.0),
            ViewTextField(labelText: "Email", bottomMargin: 10.0),
            ViewTextField(labelText: "Id", bottomMargin: 10.0),
            ViewTextField(labelText: "Department", bottomMargin: 10.0),
            ViewTextField(labelText: "Year", bottomMargin: 10.0),
            ViewTextField(labelText: "Phone Number", bottomMargin: 10.0),
            ViewTextField(labelText: "Username", bottomMargin: 10.0),
            SizedBox(height: 20.0),
            Button("Save", 0.0, onSave)
          ],
        ),
      ),
    );
  }
}
