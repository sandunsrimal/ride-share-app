import 'package:cached_network_image/cached_network_image.dart';
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
  String? phoneNo;
  bool indexx;
  SignupPage({super.key, required this.phoneNo, required this.indexx});
  
  @override
  State<SignupPage> createState() => _SignupPageState();
}
String? IDimageurl;
String? Vehicleimageurl;



class _SignupPageState extends State<SignupPage> {
   bool loading=false;
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final homenumber = TextEditingController();
  final idController = TextEditingController();

  final vehicle_number = TextEditingController();


  final auth = FirebaseAuth.instance;
  // bool index = true;
  String? gendername;
  List<Gender> genders = <Gender>[];

String? name;
  String? imageUrl;
String? vehicletype;
  File? imageFile;
  String? fileName;
  bool loadingdp = false;


  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var nameCtrl = TextEditingController();

  Future pickImage() async {
    final _imagePicker = ImagePicker();
    var imagepicked = await _imagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);

    if (imagepicked != null) {
      setState(() {
        imageFile = File(imagepicked.path);
        fileName = (imageFile!.path);
     
        uploadPicture();
      
      });
    } else {
      print('No image has is selected!');
    }
  }

  Future uploadPicture() async {
    print("Upload Picture function called");
    Reference storageReference =
        FirebaseStorage.instance.ref().child('Profile Pictures/$fileName');

    UploadTask uploadTask = storageReference.putFile(imageFile!);

    await uploadTask.whenComplete(() async {
      var _url = await storageReference.getDownloadURL();
      var _imageUrl = _url.toString();
      print("Image uploaded");

      setState(() {
        imageUrl = _imageUrl;
      });
    });
  }


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
       // physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
             
              height: height * 0.18,
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
                        if(widget.indexx){
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

                        }else{
                          Navigator.pop(context);
                        }
                       
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 70, left: 70),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.indexx ?
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
                              // setState(() {
                              //   index = true;
                              // });
                            })
                        // const SizedBox(
                        //   width: 60,
                        // )
                        
                       : InkWell(
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
                              // setState(() {
                              //   index = false;
                              // });
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
           
            widget.indexx
                ? SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20,  bottom: 20),
                   
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              child: Center(
                                child: Column(
                                  children: [
                                      InkWell(
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.grey[300],
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey[800]!),
                                  color: Colors.grey[500],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: (imageFile == null
                                      
                                          ? gendername=='Female' ? const NetworkImage("https://firebasestorage.googleapis.com/v0/b/ride-share-app-fa1ab.appspot.com/o/woman.png?alt=media&token=cebffdb9-3962-441a-baa6-0d05a3bb017d&_gl=1*1xlaw75*_ga*Njg4MTQ5ODY0LjE2ODYxMzc3NTU.*_ga_CW55HF8NVT*MTY5NjE0MDMyMS40Mi4xLjE2OTYxNDEwNDkuNDQuMC4w") 
                                          : const NetworkImage("https://firebasestorage.googleapis.com/v0/b/ride-share-app-fa1ab.appspot.com/o/man-2.png?alt=media&token=b14bd4ee-b3b4-4935-aeb5-c72ce654b410&_gl=1*1hgtj3f*_ga*Njg4MTQ5ODY0LjE2ODYxMzc3NTU.*_ga_CW55HF8NVT*MTY5NjE0MDMyMS40Mi4xLjE2OTYxNDEwNjcuMjYuMC4w")
                                        //      ? CachedNetworkImageProvider("https://firebasestorage.googleapis.com/v0/b/ride-share-app-fa1ab.appspot.com/o/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg?alt=media&token=02cea9d2-fa69-449f-928c-b320a758069e&_gl=1*162panl*_ga*Njg4MTQ5ODY0LjE2ODYxMzc3NTU.*_ga_CW55HF8NVT*MTY5NjE0MDMyMS40Mi4xLjE2OTYxNDAzMzMuNDguMC4w")
                                              : FileImage(imageFile!))
                                          as ImageProvider<Object>,
                                      fit: BoxFit.cover)),
                              child: const Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(
                                    Icons.edit,
                                    size: 30,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                          onTap: () {
                            pickImage();
                           
                          },
                                  ),
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
                    
                                            keyboardType: TextInputType.text,
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
                    
                                            keyboardType: TextInputType.text,
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
                                         const IDupload()
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
                               
                                 print("Cklicked");
                                 print("Cklicked");

                                 print("Cklicked");

                          final result = await DatabaseService().addUser(
                          firstname: fnameController.text,
                          lastname: lnameController.text,
                          email: emailController.text,
                          homenumber: homenumber.text,
                          phonenumber: widget.phoneNo!,
                          usertype: 'passenger',
                          nic: idController.text,
                          nicimage: IDimageurl!,
                          gender: gendername!,
                          age: ageController.text,
                          accountstatus: "pending",
                          dpurl: imageFile == null ? genders=='Female' 
                          ? "https://firebasestorage.googleapis.com/v0/b/ride-share-app-fa1ab.appspot.com/o/woman.png?alt=media&token=cebffdb9-3962-441a-baa6-0d05a3bb017d&_gl=1*1xlaw75*_ga*Njg4MTQ5ODY0LjE2ODYxMzc3NTU.*_ga_CW55HF8NVT*MTY5NjE0MDMyMS40Mi4xLjE2OTYxNDEwNDkuNDQuMC4w" 
                          : "https://firebasestorage.googleapis.com/v0/b/ride-share-app-fa1ab.appspot.com/o/man-2.png?alt=media&token=b14bd4ee-b3b4-4935-aeb5-c72ce654b410&_gl=1*1hgtj3f*_ga*Njg4MTQ5ODY0LjE2ODYxMzc3NTU.*_ga_CW55HF8NVT*MTY5NjE0MDMyMS40Mi4xLjE2OTYxNDEwNjcuMjYuMC4w" 
                          : imageUrl!,
                          // age: ageController.text,
                          );
                          print(result);
                          if (result!.contains('success')) {
                            setState(() {
                              loading=false;
                            });
                    
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(phonenumber: widget.phoneNo, usermode: true,)));
                          }
                               
                                  
                               
                                },
                                            child: 
                                            loading ? const CircularProgressIndicator()
                                            : const Text(
                                              "Sign up",
                                              style: TextStyle(fontSize: 15, color: Colors.white),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                )
                : Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                            InkWell(
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.grey[300],
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey[800]!),
                                  color: Colors.grey[500],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: (imageFile == null
                                      
                                          ? gendername=='Female' ? const NetworkImage("https://firebasestorage.googleapis.com/v0/b/ride-share-app-fa1ab.appspot.com/o/woman.png?alt=media&token=cebffdb9-3962-441a-baa6-0d05a3bb017d&_gl=1*1xlaw75*_ga*Njg4MTQ5ODY0LjE2ODYxMzc3NTU.*_ga_CW55HF8NVT*MTY5NjE0MDMyMS40Mi4xLjE2OTYxNDEwNDkuNDQuMC4w") 
                                          : const NetworkImage("https://firebasestorage.googleapis.com/v0/b/ride-share-app-fa1ab.appspot.com/o/man-2.png?alt=media&token=b14bd4ee-b3b4-4935-aeb5-c72ce654b410&_gl=1*1hgtj3f*_ga*Njg4MTQ5ODY0LjE2ODYxMzc3NTU.*_ga_CW55HF8NVT*MTY5NjE0MDMyMS40Mi4xLjE2OTYxNDEwNjcuMjYuMC4w")
                                        //      ? CachedNetworkImageProvider("https://firebasestorage.googleapis.com/v0/b/ride-share-app-fa1ab.appspot.com/o/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg?alt=media&token=02cea9d2-fa69-449f-928c-b320a758069e&_gl=1*162panl*_ga*Njg4MTQ5ODY0LjE2ODYxMzc3NTU.*_ga_CW55HF8NVT*MTY5NjE0MDMyMS40Mi4xLjE2OTYxNDAzMzMuNDguMC4w")
                                              : FileImage(imageFile!))
                                          as ImageProvider<Object>,
                                      fit: BoxFit.cover)),
                              child: const Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(
                                    Icons.edit,
                                    size: 30,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                          onTap: () {
                            pickImage();
                           
                          },
                                  ),
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
                               const IDupload()
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
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                 SizedBox(
                              height: height * 0.05,
                              width: width * 0.5,
                              child: TextFormField(
                                controller: vehicle_number,
                                // onChanged: (value) {
                                //   phonenumber = value;
                                // },
                                decoration: InputDecoration(
                                  hintText: '123456789',
                                  labelText: 'Vehicle number',
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
                                SizedBox(
                                   height: height * 0.05,
                                  width: width * 0.3,
                                  child: DecoratedBox(
                                  decoration: BoxDecoration( 
                                   //  color:Colors.lightGreen, //background color of dropdown button
                                     border: Border.all(color: Colors.orange, width:3), //border of dropdown button
                                     borderRadius: BorderRadius.circular(30), //border raiuds of dropdown button
                                  
                                  ),
                                  
                                  child:Padding(
                                    padding: const EdgeInsets.only(left:30, right:30),
                                     child:DropdownButton(
                                      value: "Car",
                                      items: const [ //add items in the dropdown 
                                        DropdownMenuItem(
                                          child: Text("car"),
                                          value: "Car",
                                        ), 
                                        DropdownMenuItem(
                                          child: Text("van"),
                                          value: "Van"
                                        ),
                                     
                                
                                      ],
                                      onChanged: (value){ //get value when changed
                                          setState(() {
                                            vehicletype=value.toString();
                                          });
                                      },
                                      icon: const Padding( //Icon at tail, arrow bottom is default icon
                                        padding: EdgeInsets.only(left:10),
                                        child:Icon(Icons.keyboard_arrow_down_sharp)
                                      ), 
                                      iconEnabledColor: Colors.black54, //Icon color
                                      style: const TextStyle(  //te
                                         color: Colors.black54, //Font color
                                         fontSize: 17 //font size on dropdown button
                                      ),
                                      
                                      dropdownColor: Colors.white, 
                                    //dropdown background color
                                     //remove underline
                                      isExpanded: true, //make true to make width 100%
                                     )
                                  )
                                ),
                                ),
                              ],
                            ),
                          ),
                               const SizedBox(
                            height: 10,
                          ),
                          const VehicleImage(),
                         
                          const SizedBox(
                            height: 10,
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
                phonenumber: widget.phoneNo!,
                usertype: 'driver',
                nic: idController.text,
                nicimage: IDimageurl!,
                gender: gendername!,
                age: ageController.text,
                accountstatus: "pending",
                vehicletype: vehicletype!,
                vehiclenumber: "123456789",
                vehicleimage: Vehicleimageurl!,
                
                
                );
                if (result!.contains('success')) {
                  setState(() {
                    loading=false;
                  });
      
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(phonenumber: widget.phoneNo, usermode: false,)));
                }
           
              
           
            },
                                  child: 
                                  loading ? const CircularProgressIndicator()
                                  : const Text(
                                    "Sign up",
                                    style: TextStyle(fontSize: 15, color: Colors.white),
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

class VehicleImage extends StatefulWidget {
  const VehicleImage({super.key});

  @override
  State<VehicleImage> createState() => _VehicleImageState();
}

class _VehicleImageState extends State<VehicleImage> {
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
    //final destination = 'files/$fileName';

    try {
      // final ref = firebase_storage.FirebaseStorage.instance
      //     .ref(destination)
      //     .child('file/');
      // await ref.putFile(_photo!);
      var imageName = DateTime.now().millisecondsSinceEpoch.toString();
								var storageRef = FirebaseStorage.instance.ref().child('Vehicle_images/$imageName.jpg');
                
      var uploadTask = storageRef.putFile(_photo!);
      var downloadUrl = await (await uploadTask).ref.getDownloadURL();
      Vehicleimageurl=downloadUrl.toString();
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
          child: InkWell(
            onTap: () {
              _showPicker(context);
            },
            child: SizedBox(
              height: 100,
              width: 200,
              child: Container(
               
                child: _photo != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
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
                            borderRadius: BorderRadius.circular(20)),
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
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