import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String btnText;
  final double bottomMargin;

  Button(this.btnText, this.bottomMargin);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: bottomMargin),
        child: SizedBox(
          width: 200, 
          height: 50, 
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
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
