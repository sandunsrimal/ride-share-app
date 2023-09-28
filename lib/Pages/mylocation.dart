import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rideshareapp/Pages/login.dart';

import '../Utils/next_screen.dart';
import 'availiable_rides.dart';

class HomePage extends StatefulWidget {
  String? phonenumber;
 HomePage({Key? key, required this.phonenumber}) : super(key: key);

@override
_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final Completer<GoogleMapController> _controller = Completer();
  bool index = true;
  bool loading = false; 
// on below line we have specified camera position
static const CameraPosition _kGoogle = CameraPosition(
	target: LatLng(7.8731, 80.7718),
	zoom: 8,
);

// on below line we have created the list of markers
final List<Marker> _markers = <Marker>[
	const Marker(
		markerId: MarkerId('1'),
	position: LatLng(7.8731, 80.7718),
	infoWindow: InfoWindow(
		title: 'My Position',
	)
),
];

// created method for getting user current location
Future<Position> getUserCurrentLocation() async {
	await Geolocator.requestPermission().then((value){
	}).onError((error, stackTrace) async {
	await Geolocator.requestPermission();
	print("ERROR"+error.toString());
	});
	return await Geolocator.getCurrentPosition();
}

 signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
@override
Widget build(BuildContext context) {
	return Scaffold(
	
	body: Stack(
    children: [
      SizedBox(

        child: GoogleMap(
        // on below line setting camera position
        initialCameraPosition: _kGoogle,
        
        // on below line we are setting markers on the map
        markers: Set<Marker>.of(_markers),
        // on below line specifying map type.
        mapType: MapType.normal,
        // on below line setting user location enabled.
        myLocationEnabled: true,
        // on below line setting compass enabled.
        compassEnabled: true,
        // on below line specifying controller on map complete.
        onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
          
        ),
      ),
      Positioned(
        bottom: 240,
        right: 20,
        child: FloatingActionButton(
          backgroundColor: Colors.orange,
		onPressed: () async{
		getUserCurrentLocation().then((value) async {
			print(value.latitude.toString() +" "+value.longitude.toString());

			// marker added for current users location
			_markers.add(
				Marker(
				markerId: const MarkerId("2"),
				position: LatLng(value.latitude, value.longitude),
				infoWindow: const InfoWindow(
					title: 'My Current Location',
				),
				),
        
			);

			// specified current users location
			CameraPosition cameraPosition =  CameraPosition(
			target: LatLng(value.latitude, value.longitude),
			zoom: 14,
			);

			final GoogleMapController controller = await _controller.future;
			controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
			setState(() {
			});
		});
		},
		child: const Icon(Icons.location_searching_outlined),
	),),
 
   Container(
    alignment: Alignment.topCenter,
    child: Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red,
                      Colors.orange,
                    ],
                  ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(120)),
      ),
      child:    Container(
                      margin: const EdgeInsets.only(top: 55, left: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      
                          InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(children: const [
                                  // Icon(
                                  //   Icons.person_2_rounded,
                                  //   color: Colors.white,
                                  //   size: 10,
                                  // ),
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
                                  // Icon(
                                  //   Icons.drive_eta_rounded,
                                  //   color: Colors.white,
                                  //   size: 10,
                                  // ),
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
                          const SizedBox(
                            width: 60,),

                                   InkWell(
                            child: const Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 30,
                            ),
                            onTap: () {
                              signOut();
                            
                            },
                          )
                        ],
                      ),
                    ),
 
    )
   ),
     Container(
     alignment: Alignment.bottomCenter,
     child: Container(
       height: 220,
       width: MediaQuery.of(context).size.width,

       //color: Colors.white,
     // margin: EdgeInsets.only(bottom: 30),
      decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)),  
    gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red,
                      Colors.orange,
                    ],
                  ),),
       child: 
        Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 40,top: 20),
                      height: 15,
                      width: 15,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        
                      )),
            
             
                    Container(margin: EdgeInsets.only(left: 40,),
                    height: 60,
                    width: 2,
                    color: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40),
                      height: 15,
                      width: 15,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        
                      )),
                  ],
                ),
                Column(
                  children: [
                     Container(
                       margin: EdgeInsets.only(left: 20, top: 20),
                                 //     height: height * 0.05,
                                  //    width: width * 0.4,
                                  height: 40,
                                  width: 290,
                                      child: TextFormField(
                                        
                                   //     controller: lnameController,
                                        // onChanged: (value) {
                                        //   phonenumber = value;
                                        // },
                                        decoration: InputDecoration(
                                          label: const Text("From",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),),
                                    
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
            
            
             
                 const SizedBox(height: 13,),
                  Container(
                       margin: EdgeInsets.only(left: 20, top: 15),
                                 //     height: height * 0.05,
                                  //    width: width * 0.4,
                                  height: 40,
                                  width: 290,
                                      child: TextFormField(
                                   //     controller: lnameController,
                                        // onChanged: (value) {
                                        //   phonenumber = value;
                                        // },
                                        decoration: InputDecoration(
                                          label: const Text("To",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                          ),
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

                 
                
              ],

            ),
            const SizedBox(height: 20,),
             Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 150,
                    height: 40,
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
                            onPressed: () async {
                             
                              //  print(phoneNumberController.text);
                              
                                    nextScreeniOS(context, AvailiableRides());
    
                                 
                              // if (!loading) {
                              //   setState(() {
                              //     index = false;
                              //   });
                              // }

                              // print(phoneNumberController);
                            },
                            child: loading
                                ? const CircularProgressIndicator()
                                : const Padding(
                                    padding: EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Text("Search Ride"),
                                  ))
                                  ),
                  ),
                ),
          ],
        )
     ),
   ),

    
    ],
     
    ),

	// on pressing floating action button the camera will take to user current location

	);
}
}
