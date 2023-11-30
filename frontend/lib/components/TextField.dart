import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final double bottomMargin;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.bottomMargin,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: widget.bottomMargin),
          child: TextField(
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: OutlineInputBorder(),
              labelText: widget.hintText,
              labelStyle: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
