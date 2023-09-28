import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:rideshareapp/Pages/login.dart';

import '../Service/dbdriver.dart';
import '../Service/dbuser.dart';
import '../Widget/IDupload.dart';
import '../Widget/selectmap.dart';
import 'mylocation.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key, required this.phoneNo});
  String phoneNo;
  @override
  State<SignupPage> createState() => _SignupPageState();
}
String? IDimageurl;

class _SignupPageState extends State<SignupPage> {
   bool loading=false;
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final homenumber = TextEditingController();
  final idController = TextEditingController();
  final vehicle_image = TextEditingController();
  final vehicle_number = TextEditingController();
  final vehicle_type = TextEditingController();

  final auth = FirebaseAuth.instance;
  bool index = true;
  String? gendername;
  List<Gender> genders = <Gender>[];
  @override
  void initState() {
    super.initState();
    genders.add(new Gender("Male", Icons.male_rounded, false));
    genders.add(new Gender("Female", Icons.female_rounded, false));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
   
    return Scaffold(
    
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          height: height,
          child: Column(
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
                              "Sign up as a Passenger",
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
                                    controller: fnameController,
                                    // onChanged: (value) {
                                    //   phonenumber = value;
                                    // },
                                    decoration: InputDecoration(
                                      hintText: 'Sandun',
                                      labelText: 'First Name',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
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
                                        borderRadius:
                                            BorderRadius.circular(30.0),
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

                                keyboardType: TextInputType.text,
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
                                        borderRadius:
                                            BorderRadius.circular(30.0),
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
                                 IDupload()
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 40,
                              //   width: width,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: genders.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: InkWell(
                                        // splashColor: Colors.transparent,
                                        onTap: () {
                                          setState(() {
                                            genders.forEach((gender) =>
                                                gender.isSelected = false);
                                            genders[index].isSelected = true;
                                            gendername = genders[index].name;
                                            print(gendername);
                                          });
                                        },
                                        child: CustomRadio(genders[index]),
                                      ),
                                    );
                                  }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                             SizedBox(
                              height: height * 0.05,
                              width: width * 0.85,
                              child: TextFormField(
                                controller: ageController,
                                // onChanged: (value) {
                                //   phonenumber = value;
                                // },
                                decoration: InputDecoration(
                                  hintText: '2000',
                                  labelText: 'Birth Year',
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
                              height: 20,
                            ),
                            SizedBox(
                              height: height * 0.05,
                              width: width * 0.85,
                              child: TextFormField(
                                controller: addressController,
                                // onChanged: (value) {
                                //   phonenumber = value;
                                // },
                                decoration: InputDecoration(
                                  hintText: 'B76,Parangiyawadiya,Anuradhapura District,Sri Lanka',
                                  labelText: 'Home Address',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),

                                keyboardType: TextInputType.text,
                                // validator: (String? value) {
                                //   if (value!.length != 9)
                                //     return "enter valied phone number";
                                //   // return null;
                                // },
                              ),
                            ),
                             
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: height * 0.05,
                              width: width * 0.85,
                              child: TextFormField(
                                controller: homenumber,
                                // onChanged: (value) {
                                //   phonenumber = value;
                                // },
                                decoration: InputDecoration(
                                  hintText: '0766033817',
                                  labelText: 'Home contact number',
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
                              height: 20,
                            ),
                          
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
                                            color: Color.fromRGBO(0, 0, 0,
                                                0.57), //shadow for button
                                            blurRadius:
                                                5) //blur radius of shadow
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
                                    onPressed: () async {
                                       setState(() {
                      loading=true;
                    });
             
               
                  final result = await DatabaseService().addUser(
                  firstname: fnameController.text,
                  lastname: lnameController.text,
                  email: emailController.text,
                  homenumber: homenumber.text,
                  phonenumber: widget.phoneNo,
                  usertype: 'passenger',
                  nic: idController.text,
                  nicimage: IDimageurl!,
                  gender: gendername!,
                  age: ageController.text,
                  accountstatus: "pending",
                  // age: ageController.text,
                  );
                  if (result!.contains('success')) {
                    setState(() {
                      loading=false;
                    });

               Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(phonenumber: widget.phoneNo,)));
                  }
             
                
             
              },
                                    child: 
                                    loading ? const CircularProgressIndicator()
                                    : const Text(
                                      "Sign up",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Center(
                        child: Column(
                          children: [
                            const Text(
                              "Sign up as a Driver",
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
                                    controller: fnameController,
                                    // onChanged: (value) {
                                    //   phonenumber = value;
                                    // },
                                    decoration: InputDecoration(
                                      hintText: 'Sandun',
                                      labelText: 'First Name',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
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
                                        borderRadius:
                                            BorderRadius.circular(30.0),
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

                                keyboardType: TextInputType.text,
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
                                      hintText: '123456789',
                                      labelText: 'Driving License',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
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
                                 IDupload()
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 40,
                              //   width: width,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: genders.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: InkWell(
                                        // splashColor: Colors.transparent,
                                        onTap: () {
                                          setState(() {
                                            genders.forEach((gender) =>
                                                gender.isSelected = false);
                                            genders[index].isSelected = true;
                                            gendername = genders[index].name;
                                            print(gendername);
                                          });
                                        },
                                        child: CustomRadio(genders[index]),
                                      ),
                                    );
                                  }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                             
                            SizedBox(
                              height: height * 0.05,
                              width: width * 0.85,
                              child: TextFormField(
                                controller: addressController,
                                // onChanged: (value) {
                                //   phonenumber = value;
                                // },
                                decoration: InputDecoration(
                                  hintText: 'B76,Parangiyawadiya,Anuradhapura District,Sri Lanka',
                                  labelText: 'Home Address',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),

                                keyboardType: TextInputType.text,
                                // validator: (String? value) {
                                //   if (value!.length != 9)
                                //     return "enter valied phone number";
                                //   // return null;
                                // },
                              ),
                            ),
                             
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: height * 0.05,
                              width: width * 0.85,
                              child: TextFormField(
                                controller: homenumber,
                                // onChanged: (value) {
                                //   phonenumber = value;
                                // },
                                decoration: InputDecoration(
                                  hintText: '0766033817',
                                  labelText: 'Home contact number',
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
                              height: 20,
                            ),
                          
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
                                            color: Color.fromRGBO(0, 0, 0,
                                                0.57), //shadow for button
                                            blurRadius:
                                                5) //blur radius of shadow
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
                                    onPressed: () async {
                                       setState(() {
                      loading=true;
                    });
             
               
                  final result = await DatabaseServiceDriver().addUser(
                  firstname: fnameController.text,
                  lastname: lnameController.text,
                  email: emailController.text,
                  homenumber: homenumber.text,
                  phonenumber: widget.phoneNo,
                  usertype: 'driver',
                  nic: idController.text,
                  nicimage: IDimageurl!,
                  gender: gendername!,
                  age: ageController.text,
                  accountstatus: "pending",
                  vehicletype: "car",
                  vehiclenumber: "123456789",
                  vehicleimage: "imageurl"
                  
                  
                  );
                  if (result!.contains('success')) {
                    setState(() {
                      loading=false;
                    });

               Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(phonenumber: widget.phoneNo,)));
                  }
             
                
             
              },
                                    child: 
                                    loading ? const CircularProgressIndicator()
                                    : const Text(
                                      "Sign up",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class Gender {
  String name;
  IconData icon;
  bool isSelected;

  Gender(this.name, this.icon, this.isSelected);
}

class CustomRadio extends StatelessWidget {
  Gender _gender;

  CustomRadio(this._gender);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 20,
      width: 120,
      decoration: BoxDecoration(
          gradient: _gender.isSelected
              ? const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.red,
                    Colors.orange,
                  ],
                )
              : const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.black12,
                    Colors.black12,
                  ],
                ),
          //    color: _gender.isSelected ? Colors.orange : Colors.black12,
          borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      // margin: new EdgeInsets.all(15.0),
      // padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            _gender.icon,
            color: _gender.isSelected ? Colors.white : Colors.grey,
            size: 40,
          ),
          //     SizedBox(height: 10),
          Text(
            _gender.name,
            style: TextStyle(
                color: _gender.isSelected ? Colors.white : Colors.grey),
          )
        ],
      ),
    );
  }
}




class IDupload extends StatefulWidget {
  const IDupload({super.key});

  @override
  State<IDupload> createState() => _IDuploadState();
}

class _IDuploadState extends State<IDupload> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      // final ref = firebase_storage.FirebaseStorage.instance
      //     .ref(destination)
      //     .child('file/');
      // await ref.putFile(_photo!);
      var imageName = DateTime.now().millisecondsSinceEpoch.toString();
								var storageRef = FirebaseStorage.instance.ref().child('ID_images/$imageName.jpg');
      var uploadTask = storageRef.putFile(_photo!);
      var downloadUrl = await (await uploadTask).ref.getDownloadURL();
      IDimageurl=downloadUrl.toString();
    } catch (e) {
      print('error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.orange,
              child: _photo != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _photo!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 53,
                      height: 53,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
          ),
        )
      ],
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
