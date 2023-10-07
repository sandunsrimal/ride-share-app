import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Pages/login.dart';
import '../Pages/mylocation.dart';
import '../Pages/signup.dart';

    final auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


class SplashServices {
  void isLogin(BuildContext context) {

    if (auth.currentUser != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context){
                    
                    return HomePage(
                      phonenumber: auth.currentUser!.phoneNumber,
                      usermode: true, 
                    );
                  }
                      )));
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

// HomePage(
//                         phonenumber: auth.currentUser!.phoneNumber,
//                         usermode: true, 
//                       )