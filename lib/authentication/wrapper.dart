import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:servicehub/authentication/phone_auth.dart';
import 'package:servicehub/homescreen/homescreen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          return PhoneLoginScreen();
        }
      },
    ));
  }
}
