import 'package:allen/screens/HomePage.dart';
import 'package:allen/screens/SignupScreen.dart';
import 'package:allen/widgets/Textfield.dart';
import 'package:allen/widgets/buttons.dart';
import 'package:allen/widgets/logowidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordtextcontroller = TextEditingController();
  TextEditingController _emailtextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 107, 34, 123),
          Color.fromARGB(255, 72, 55, 169),
          Color.fromARGB(255, 20, 190, 233)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  image(180, 180),
                  const SizedBox(height: 30),
                  textField("username", Icons.supervised_user_circle, false,
                      _emailtextcontroller),
                  const SizedBox(
                    height: 30,
                  ),
                  textField("Enter password", Icons.lock_outline, true,
                      _passwordtextcontroller),
                  const SizedBox(
                    height: 20,
                  ),
                  Buttons(context, true, () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailtextcontroller.text,
                            password: _passwordtextcontroller.text)
                        .then((value) {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()))
                          .onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                      });
                    });
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Dont't have account?",
                        style: TextStyle(color: Colors.white70),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
