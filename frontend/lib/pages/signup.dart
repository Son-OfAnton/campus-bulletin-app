import 'package:flutter/material.dart';
import '../components/TextField.dart';
import '../components/CustomAppBar.dart';
import '../components/Button.dart';
class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
          body: Padding(
        padding: EdgeInsets.all(26),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Signup",
                style: TextStyle(
                  color: Color(0xFF322828),
                  fontFamily: 'Poppins',
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // First TextField as a box
              CustomTextField(
                hintText: 'Full name',
                bottomMargin: 15.0,
              ),

              // Second TextField as a box
              
              CustomTextField(
                hintText: 'Email',
                bottomMargin: 15.0,
              ),
              CustomTextField(
                hintText: 'Password',
                bottomMargin: 15.0,
              ),
              CustomTextField(
                hintText: 'Confirm Password',
                bottomMargin: 20.0,
              ),
              
              Button(
                btnText: "Sign up",
              )
            ],
          ),
        ),
      ),
    );
  }
}
