// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Post an announcement',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                  labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Body',
                  labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Attachments',
                  labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                  labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Author',
                  labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Issued from',
                  labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Issued to',
                  labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              SizedBox(height: 16.0),
              Text('Importance', style: TextStyle(fontSize: 14)),
              SizedBox(height: 16.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: <Widget>[
                  RoundedChip(label: 'Low', color: Colors.green),
                  RoundedChip(label: 'Medium', color: Colors.yellow),
                  RoundedChip(label: 'High', color: Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class RoundedChip extends StatefulWidget {
  final String label;
  final Color color;

  RoundedChip({Key? key, required this.label, required this.color})
      : super(key: key);

  @override
  _RoundedChipState createState() => _RoundedChipState();
}

class _RoundedChipState extends State<RoundedChip> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Chip(
          label: Text(widget.label),
          shape: StadiumBorder(
            side: BorderSide.none,
          ),
          side: BorderSide(
            color: isSelected
                ? widget.color
                : Theme.of(context).dividerColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
