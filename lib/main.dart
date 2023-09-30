import 'package:flutter/material.dart';
import 'package:rideshareapp/Pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rideshareapp/Pages/signup.dart';

// import 'Pages/home.dart';

import 'Pages/mylocation.dart';
import 'Pages/spash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RideShare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.orange),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Colors.orange),
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
      ),
      home: const SplashScreen(),
      // home:     SignupPage(phoneNo: '766033817',),
      // home: SignupPage(
      //   phoneNo: '766033817',
      // ),
    );
  }
}
