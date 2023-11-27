import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String btnText; 
  Button({required this.btnText}); 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add your button click logic here
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF6750A4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            btnText,
            style: TextStyle(
                fontSize: 16, color: Colors.white), 
          ),
        ),
      ),
    );
  }
}
