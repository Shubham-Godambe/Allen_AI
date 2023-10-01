import 'package:allen/screens/HomePage.dart';
import 'package:allen/widgets/Textfield.dart';
import 'package:allen/widgets/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _userNametextController = TextEditingController();
  TextEditingController _emailtextcontroller = TextEditingController();
  TextEditingController _passwordtextcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        title: const Text(
          "Sign - Up",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white70),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 107, 34, 123),
          Color.fromARGB(255, 72, 55, 169),
          Color.fromARGB(255, 20, 190, 233)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: [
                textField("Enter UserName", Icons.person_2_outlined, false,
                    _userNametextController),
                const SizedBox(
                  height: 20,
                ),
                textField("Enter your email", Icons.email_outlined, false,
                    _emailtextcontroller),
                const SizedBox(
                  height: 20,
                ),
                textField("password", Icons.password_sharp, false,
                    _passwordtextcontroller),
                const SizedBox(
                  height: 25,
                ),
                Buttons(context, false, () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailtextcontroller.text,
                          password: _passwordtextcontroller.text)
                      .then((value) {
                    print("we are sign up");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  }).onError((error, stackTrace) {
                    print("We have some problem ${error.toString()}");
                  });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
