import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Pages/login.dart';
import '../Pages/mylocation.dart';
import '../Pages/signup.dart';

    final auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
QuerySnapshot? data;
String? phone;
bool hasaccount = false;


class SplashServices {
  Future<void> isLogin(BuildContext context) async {

    if (auth.currentUser != null) {
    

      phone = auth.currentUser!.phoneNumber;
         QuerySnapshot data;

   print("object");
      data = await firestore
          .collection('users')
          .where('phone_number', isEqualTo: phone)

          //  .orderBy('latitude', descending: false)
          //   .limit(10)
          .get();
   

    if (data.docs.length > 0) {
         print("object");
      hasaccount = true;
     
    } else{
         print("object 1");
    }

      if(hasaccount){
           print("object 3");
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
      }


    

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

Future<Null> _getData() async {
  
    QuerySnapshot data;

   print("object");
      data = await firestore
          .collection('users')
          .where('phone_number', isEqualTo: phone)

          //  .orderBy('latitude', descending: false)
          //   .limit(10)
          .get();
   

    if (data.docs.length > 0) {
         print("object");
      hasaccount = true;
     
    } else{
         print("object 1");
    }
    return null;
  }