import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rideshareapp/Pages/login.dart';

import '../Widget/IDupload.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key, required this.phoneNo});
  String phoneNo;
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final idController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool index = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      // leading: IconButton(
      //   icon: const Icon(Icons.arrow_back, color: Colors.white),
      //   onPressed: () => Navigator.of(context).pop(),
      // ),
      //   actions: [
      //     IconButton(
      // onPressed: () {
      //   auth.signOut().then((value) {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => const LoginPage()));
      //   }).onError((error, stackTrace) {
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           title: const Text("Error"),
      //           content: Text(error.toString()),
      //           actions: <Widget>[
      //             TextButton(
      //               child: const Text("close"),
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //               },
      //             ),
      //           ],
      //         );
      //       },
      //     );
      //   });
      // },
      //         icon: const Icon(Icons.logout_rounded)),
      //     const SizedBox(
      //       width: 10,
      //     )
      //   ],
      // ),
      body: Column(
        children: [
          Container(
            height: height * 0.2,
            width: width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.red,
                  Colors.orange,
                ],
              ),
              // color: Colors.orange,
              borderRadius: BorderRadius.only(
                // bottomRight: Radius.circular(100.0),
                bottomLeft: Radius.circular(120.0),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  top: 60,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white),
                    onPressed: () {
                      auth.signOut().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      }).onError((error, stackTrace) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Error"),
                              content: Text(error.toString()),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text("close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 90, left: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(children: const [
                              Icon(
                                Icons.person_2_rounded,
                                color: Colors.white,
                                size: 50,
                              ),
                              // Image.asset(
                              //   "name",
                              //   scale: 2,
                              // ),
                              Text(
                                "Passenger",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                          ),
                          onTap: () {
                            setState(() {
                              index = true;
                            });
                          }),
                      const SizedBox(
                        width: 60,
                      ),
                      InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(children: const [
                              Icon(
                                Icons.drive_eta_rounded,
                                color: Colors.white,
                                size: 50,
                              ),
                              Text(
                                "Driver",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                          ),
                          onTap: () {
                            setState(() {
                              index = false;
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          index
              ? Container(
                  alignment: Alignment.center,
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height * 0.05,
                              width: width * 0.4,
                              child: TextFormField(
                                controller: lnameController,
                                // onChanged: (value) {
                                //   phonenumber = value;
                                // },
                                decoration: InputDecoration(
                                  hintText: 'Sandun',
                                  labelText: 'First Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),

                                keyboardType: TextInputType.number,
                                // validator: (String? value) {
                                //   if (value!.length != 9)
                                //     return "enter valied phone number";
                                //   // return null;
                                // },
                              ),
                            ),
                            const SizedBox(
                              width: 22,
                            ),
                            SizedBox(
                              height: height * 0.05,
                              width: width * 0.4,
                              child: TextFormField(
                                controller: lnameController,
                                // onChanged: (value) {
                                //   phonenumber = value;
                                // },
                                decoration: InputDecoration(
                                  hintText: 'Srimal',
                                  labelText: 'Last Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),

                                keyboardType: TextInputType.number,
                                // validator: (String? value) {
                                //   if (value!.length != 9)
                                //     return "enter valied phone number";
                                //   // return null;
                                // },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: height * 0.05,
                          width: width * 0.85,
                          child: TextFormField(
                            controller: emailController,
                            // onChanged: (value) {
                            //   phonenumber = value;
                            // },
                            decoration: InputDecoration(
                              hintText: 'Sandun@email.com',
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),

                            keyboardType: TextInputType.number,
                            // validator: (String? value) {
                            //   if (value!.length != 9)
                            //     return "enter valied phone number";
                            //   // return null;
                            // },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height * 0.05,
                              width: width * 0.69,
                              child: TextFormField(
                                controller: idController,
                                // onChanged: (value) {
                                //   phonenumber = value;
                                // },
                                decoration: InputDecoration(
                                  hintText: '123456789v',
                                  labelText: 'NIC',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),

                                keyboardType: TextInputType.number,
                                // validator: (String? value) {
                                //   if (value!.length != 9)
                                //     return "enter valied phone number";
                                //   // return null;
                                // },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const IDupload(),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  child: const Center(
                    child: Text("as a driver"),
                  ),
                )
        ],
      ),
    );
  }
}
