import 'package:flutter/material.dart';
import '../components/TextField.dart';
import '../components/CustomAppBar.dart';
import '../components/Button.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: CustomAppBar(),
        body: Padding(
          padding: EdgeInsets.all(26),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    color: Color(0xFF322828),
                    fontFamily: 'Poppins',
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
               
                CustomTextField(
                  hintText: 'Email',
                  bottomMargin: 20.0,
                ),

    
                CustomTextField(
                  hintText: 'Password',
                  bottomMargin: 10.0,
                ),
                Button(btnText: "Sign in",)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
