import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

String imgToString(File imageFile) {
  String imgString = base64Encode(imageFile.readAsBytesSync());
  return imgString;
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token != null) {
    return token;
  } else {
    throw Exception('Token not found');
  }
}

void createChannel(String name, String description, File image) async {
  Dio dio = Dio();
  String token = await getToken();
  debugPrint('JWT Token: $token');
  String logo = imgToString(image);
  Map<String, dynamic> reqBody = {
    'name': name,
    'description': description,
    'logo': logo,
  };

  try {
    final response = await dio.post('http://localhost:5279/api/channels',
        data: reqBody,
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    debugPrint('Create Channel Response: $response');
    if (response.statusCode == 201) {
      debugPrint('Channel Created');
    } else {
      debugPrint('Channel Not Created');
    }
  } catch (e) {
    debugPrint('Channel Create Error: $e');
  }
}

Future<List<dynamic>> getSubscribedChannels() async {
  List<dynamic> channels = [];
  Dio dio = Dio();
  String token = await getToken();

  try {
    final response = await dio.get(
        'http://localhost:5279/api/channels/subscribed',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    Map<String, dynamic> responseObj = jsonDecode(response.toString());

    debugPrint('Subscribed Channels Response: $response');
    if (response.statusCode == 200) {
      debugPrint('Subscribed Channels Fetched');
      channels = responseObj['data'];
    } else {
      debugPrint('Subscribed Channels Not Fetched');
    }
  } catch (e) {
    debugPrint('Subscribed Channels Fetch Error: $e');
  }

  return channels;
}

Future<List<dynamic>> getMyChannels() async {
  String id = await getCurrUserId();
  debugPrint('#[Inside utils] current user id: $id');
  Future.delayed(const Duration(seconds: 3));
  List<dynamic> channels = [];
  Dio dio = Dio();
  String token = await getToken();

  try {
    final response = await dio.get('http://localhost:5279/api/channels/admin',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    Map<String, dynamic> responseObj = jsonDecode(response.toString());

    debugPrint('My Channels Response: $response');
    if (response.statusCode == 200) {
      debugPrint('My Channels Fetched wooohooooo');
      channels = responseObj['data'];
    } else {
      debugPrint('My Channels Not Fetched');
    }
  } catch (e) {
    debugPrint('My Channels Fetch Error: $e');
  }

  return channels;
}

Future<String> getCurrUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  Dio dio = Dio();

  try {
    final response = await dio.get('http://localhost:5279/api/user',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    Map<String, dynamic> responseObj = jsonDecode(response.toString());
    if (response.statusCode == 200) {
      debugPrint('Current User Fetched');
      return responseObj['data']['id'];
    } else {
      debugPrint('User Not Fetched');
      return '';
    }
  } catch (e) {
    debugPrint('User Fetch Error: $e');
  }

  debugPrint('I should not arrive here');
  return '';
}
