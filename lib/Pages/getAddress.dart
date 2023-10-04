import 'dart:async';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:map_picker/map_picker.dart';
import 'package:geocoding/geocoding.dart';

import 'mylocation.dart';




class MyHomePage extends StatefulWidget {
  String phoneNumber;
   MyHomePage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(7.8731, 80.7718),
    zoom: 8,
  );

  var textController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapPicker(
            // pass icon widget
            iconWidget: const Icon(
              Icons.location_pin,
              size: 50,
              color: Colors.red,
            ),
            //add map picker controller
            mapPickerController: mapPickerController,
            child: GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              // hide location button
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              //  camera position
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMoveStarted: () {
                // notify map is moving
                mapPickerController.mapMoving!();
                textController.text = "checking ...";
              },
              onCameraMove: (cameraPosition) {
                this.cameraPosition = cameraPosition;
              },
              onCameraIdle: () async {
                // notify map stopped moving
                mapPickerController.mapFinishedMoving!();
                //get address name from camera position
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  cameraPosition.target.latitude,
                  cameraPosition.target.longitude,
                );

                // update the ui with the address
                textController.text =
                '${placemarks.first.name}, ${placemarks.first.administrativeArea}';
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top + 20,
            width: MediaQuery.of(context).size.width - 50,
            height: 60,
            child: TextFormField(
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.bold),
              readOnly: true,
             decoration: InputDecoration(
                                            icon: IconButton(
                                              iconSize: 30,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: const CircleAvatar(
                                              //  radius: 20,
                                                backgroundColor: Colors.orange,
                                                child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 25,)),
                                            ),
                                              label: const Text("",
                                              
                                              
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                                
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(30.0),
                                                    borderSide: const BorderSide(
                                                      color: Colors.orange,
                                                      width: 3.0,
                                                    ),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(30.0),
                                                    borderSide: const BorderSide(
                                                      color: Colors.orange,
                                                      width: 3.0,
                                                    ),
                                                  ),
                                              border: OutlineInputBorder(
                                                  borderSide:
                                                     const BorderSide(width: 3, color: Colors.white), 
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                            ),
              controller: textController,
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 250,
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
                                onPressed: () async  {
                                 
                                  //  print(phoneNumberController.text);
                                        print(
                      "Location ${cameraPosition.target.latitude} ${cameraPosition.target.longitude}");
                  print("Address: ${textController.text}");
                                     Addres().setAddress(textController.text, cameraPosition.target.latitude, cameraPosition.target.longitude);
                                     Addres().setValues();
                                     Navigator.push(context, MaterialPageRoute(builder: (context) =>HomePage(phonenumber: widget.phoneNumber)));
                                   //  Navigator.pop(context, true);
    
                                     
                                  // if (!loading) {
                                  //   setState(() {
                                  //     index = false;
                                  //   });
                                  // }

                                  // print(phoneNumberController);
                                },
                                child:  const Padding(
                                        padding: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                        ),
                                        child: Text("Get Location", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),),
                                      ))
                                      ),
                      ),
                    ),
            // child: SizedBox(
            //   height: 50,
            //   child: TextButton(
            //     child: const Text(
            //       "Submit",
            //       style: TextStyle(
            //         fontWeight: FontWeight.w400,
            //         fontStyle: FontStyle.normal,
            //         color: Color(0xFFFFFFFF),
            //         fontSize: 19,
            //         // height: 19/19,
            //       ),
            //     ),
            //     onPressed: () {
            //       print(
            //           "Location ${cameraPosition.target.latitude} ${cameraPosition.target.longitude}");
            //       print("Address: ${textController.text}");
            //     },
            //     style: ButtonStyle(
            //       backgroundColor:
            //       MaterialStateProperty.all<Color>(const Color(0xFFA3080C)),
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(15.0),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          )
        ],
      ),
    );
  }



}