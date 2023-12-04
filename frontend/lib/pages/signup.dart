import 'package:flutter/material.dart';
import '../components/TextField.dart';
import '../components/CustomAppBar.dart';
import '../components/Button.dart';
import 'login.dart';

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
              Container(
                margin:
                    EdgeInsets.only(bottom: 30),
                child:
              Text(
                "Signup",
                style: TextStyle(
                  color: Color(0xFF322828),
                  fontFamily: 'Poppins',
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),),
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
                bottomMargin: 30.0,
              ),
              
              Button(
                 "Sign up",
                 50.0
              ), 
              Column(
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Color(0xFF322828),
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Login()), 
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Sign in",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
