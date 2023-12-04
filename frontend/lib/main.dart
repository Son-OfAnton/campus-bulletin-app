// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/channels.dart';
import 'pages/edit_profile.dart';
import 'pages/login.dart';
import 'pages/post.dart';
import 'pages/single_channel.dart';
import 'pages/view_profile.dart';
import 'pages/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Bulleting Board',
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'Home Page'),
      routes: {
        '/login': (context) => Login(),
        '/channels': (context) => const Channels(),
        '/editProfile': (context) => const EditProfile(),
        '/post': (context) => const Post(),
        '/singleChannel': (context) => const SingleChannel(),
        '/viewProfile': (context) => const ViewProfile(),
        '/signup': (context) => Signup(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> routeNames = [
    '/login',
    '/channels',
    '/editProfile',
    '/post',
    '/singleChannel',
    '/viewProfile',
     '/signup',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buildButtons(context),
        ),
      ),
    );
  }

  List<Widget> buildButtons(BuildContext context) {
    return routeNames.map((routeName) {
      return TextButton(
        onPressed: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Text(routeName.substring(1)), // Removing the leading '/'
      );
    }).toList();
  }
}
