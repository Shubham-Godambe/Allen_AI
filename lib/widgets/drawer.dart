import 'package:allen/screens/signin.dart';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideInRight(
      child: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(209, 122, 142, 158),
                ),
                child: Center(
                    child: Text(
                  'MENU-BAR',
                  style: TextStyle(
                      fontFamily: AutofillHints.countryCode,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                )),
              ),
              ListTile(
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Save'),
                onTap: () {},
              ),
              FloatingActionButton(
                isExtended: true,
                hoverColor: Colors.grey,
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("We are logged out");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()));
                  });
                },
                child: Text("Log-Out"),
              )
            ],
          )),
    );
  }
}
