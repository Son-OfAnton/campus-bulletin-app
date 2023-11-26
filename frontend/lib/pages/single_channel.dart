import 'package:flutter/material.dart';

class SingleChannel extends StatelessWidget {
  const SingleChannel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SingleChannel'),
      ),
      body: const Center(
        child: Text('SingleChannel'),
      ),
    );
  }
}
