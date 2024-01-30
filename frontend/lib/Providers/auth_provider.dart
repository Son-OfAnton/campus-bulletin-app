import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<bool> registerUser(Map<String, dynamic> userData) async {
    try {
      final response = await _dio.post(
        'http://localhost:5006/api/user/register',
        data: userData,
      );

      if (response.statusCode == 200) {
        debugPrint('User registration successful: $response');
        return true;
      } else {
        debugPrint('Error during user registration: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      debugPrint('Error during user registration: $error');
      return false;
    }
  }
}

final authService = AuthService();

final registrationProvider =
    FutureProvider.family<bool, Map<String, dynamic>>((ref, userData) async {
  try {
    final success = await authService.registerUser(userData);
    return success;
  } catch (error) {
    debugPrint('Error during user registration: $error');
    return false;
  }
});

final sharedPrefsProvider = FutureProvider((ref) async {
  final sharedPrefs = await SharedPreferences.getInstance();
  return sharedPrefs;
});

final formDataProvider = Provider<Map<String, dynamic>>((ref) {
  final sharedPrefs = ref.watch(sharedPrefsProvider);

  return sharedPrefs.when(
      data: (sharedPrefs) {
        return {
          'firstName': sharedPrefs.getString('firstName'),
          'lastName': sharedPrefs.getString('lastName'),
          'userName': sharedPrefs.getString('userName'),
          'email': sharedPrefs.getString('email'),
          'department': sharedPrefs.getInt('department'),
          'year': sharedPrefs.getInt('year'),
          'phoneNumber': sharedPrefs.getString('phoneNumber'),
          'password': sharedPrefs.getString('password'),
          'avatar': sharedPrefs.getString('avatar'),
        };
      },
      loading: () => {},
      error: (error, stackTrace) => {});
});

final imageFileProvider =
    StateNotifierProvider<ImageFileNotifier, File?>((ref) {
  return ImageFileNotifier();
});

class ImageFileNotifier extends StateNotifier<File?> {
  ImageFileNotifier() : super(null);

  final ImagePicker _imagePicker = ImagePicker();
  String imageUrl = 'https://picsum.photos/250?image=9';

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      state = File(pickedFile.path);
    }
  }
}