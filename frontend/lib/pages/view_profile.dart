import 'package:flutter/material.dart';
import '../components/NotificationBellIcon.dart';
class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ViewProfile'),
          actions: <Widget>[
    NotificationBellIcon(),
  ],
      ),
      body: const Center(
        child: Text('ViewProfile'),
      ),
    );
  }
}
