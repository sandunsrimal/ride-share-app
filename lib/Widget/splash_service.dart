import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Pages/login.dart';
import '../Pages/mylocation.dart';
import '../Pages/signup.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        phonenumber: auth.currentUser!.phoneNumber,
                        usermode: true,
                      ))));
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => SignupPage()));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage())));
    }
  }
}
