import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../components/Photoviewer.dart';
import '../components/viewProfileTextfield.dart';
import '../components/Button.dart';

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
    final pickedFile = await _imagePicker.getImage(source: source);
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
      return response
          .data['imageUrl']; 
    } catch (error) {
      print("Error uploading image: $error");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 203, 171, 253),
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Stack(
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
                      child: Text('Edit'),
                    ),
                  ),
                ],
              ),
            ),
            ViewTextField(labelText: "Full Name", bottomMargin: 10.0),
            ViewTextField(labelText: "Email", bottomMargin: 10.0),
            ViewTextField(labelText: "Id", bottomMargin: 10.0),
            ViewTextField(labelText: "Department", bottomMargin: 10.0),
            ViewTextField(labelText: "Year", bottomMargin: 10.0),
            ViewTextField(labelText: "Phone Number", bottomMargin: 10.0),
            ViewTextField(labelText: "Username", bottomMargin: 10.0),
            SizedBox(height: 20.0),
            Button("Save", 0.0)
          ],
        ),
      ),
    );
  }
}
