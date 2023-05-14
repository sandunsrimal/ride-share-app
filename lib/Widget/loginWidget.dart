import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool index = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return index == true
        ? Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Hello! nice to meet you",
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  "Get moving with SHIDE",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/sri-lanka.png",
                          width: 70.0,
                        )),
                    const Spacer(),
                    SizedBox(
                      width: width * 0.1,
                      child: const Text(
                        "+94",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: width * 0.6,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: '766033817',
                          labelText: 'Phone number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),

                        keyboardType: TextInputType.number,
                        // validator: (String? value) {
                        //   if (value!.length == 0)
                        //     return "Phone number can't be empty";
                        //   return null;
                        // },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Colors.orange,
                              Colors.red,

                              //add more colors
                            ]),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.57), //shadow for button
                                  blurRadius: 5) //blur radius of shadow
                            ]),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              disabledForegroundColor:
                                  Colors.transparent.withOpacity(0.38),
                              disabledBackgroundColor:
                                  Colors.transparent.withOpacity(0.12),
                              shadowColor: Colors.transparent,
                              //make color or elevated button transparent
                            ),
                            onPressed: () {
                              print("You pressed Elevated Button");
                              setState(() {
                                index = false;
                                ;
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 18,
                                bottom: 18,
                              ),
                              child: Text("Continue"),
                            ))),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Powered by:",
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                        width: 100,
                        child: Image.asset(
                            "assets/images/beesoftlogo edited.png")),
                  ],
                ),
              ],
            ),
          )
        : Container(
            child: Column(
              children: [
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: GestureDetector(
                //     // onTap: () => Navigator.pop(context),
                //     child: Icon(
                //       Icons.arrow_back,
                //       size: 32,
                //       color: Colors.black54,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Verification',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Enter your OTP code number",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                // const SizedBox(
                //   height: 8,
                // ),
                Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _textFieldOTP(first: true, last: false),
                          _textFieldOTP(first: false, last: false),
                          _textFieldOTP(first: false, last: false),
                          _textFieldOTP(first: false, last: true),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 12,
                      // ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Colors.orange,
                                  Colors.red,

                                  //add more colors
                                ]),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                      color: Color.fromRGBO(
                                          0, 0, 0, 0.57), //shadow for button
                                      blurRadius: 5) //blur radius of shadow
                                ]),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                disabledForegroundColor:
                                    Colors.transparent.withOpacity(0.38),
                                disabledBackgroundColor:
                                    Colors.transparent.withOpacity(0.12),
                                shadowColor: Colors.transparent,
                                //make color or elevated button transparent
                              ),
                              onPressed: () {
                                print("You pressed Verify Button");
                                setState(() {
                                  index = false;
                                  ;
                                });
                              },
                              child: const Text("Verify"),
                            )),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 8,
                // ),
                const Text(
                  "Didn't you receive any code?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Resend New Code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  child: const Text(
                    "Back",
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    setState(() {
                      index = true;
                    });
                  },
                )
              ],
            ),
          );
  }

  Widget _textFieldOTP({required bool first, last}) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 70,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.orange),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
