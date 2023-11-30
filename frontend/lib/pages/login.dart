import 'package:flutter/material.dart';
import '../components/TextField.dart';
import '../components/CustomAppBar.dart';
import '../components/Button.dart';
import 'signup.dart';

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
                Container(
                  margin:
                      EdgeInsets.only(bottom: 20), 
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Color(0xFF322828),
                      fontFamily: 'Poppins',
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CustomTextField(
                  hintText: 'Email',
                  bottomMargin: 20.0,
                ),
                CustomTextField(
                  hintText: 'Password',
                  bottomMargin: 30.0,
                ),
                Button("Sign in", 100.0),
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
                                  Signup()), 
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Sign up",
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
      ),
    );
  }
}
