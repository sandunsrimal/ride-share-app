import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rideshareapp/Pages/login.dart';
import 'package:rideshareapp/Widget/NavBar.dart';

import '../Utils/next_screen.dart';
import '../Widget/navigation_screen.dart';
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
  bool usermode = true;
  int seats = 1;
  double lat = 0.0;
  double lng = 0.0;
// on below line we have specified camera position
static const CameraPosition _kGoogle = CameraPosition(
	target: LatLng(7.8731, 80.7718),
	zoom: 8,
);

// on below line we have created the list of markers
final List<Marker> _markers = <Marker>[
// 	const Marker(
// 		markerId: MarkerId('1'),
// 	position: LatLng(7.8731, 80.7718),
// 	infoWindow: InfoWindow(
// 		title: 'My Position',
// 	)
// ),
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
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
  @override
  void initState() {
    // TODO: implement initState
    getUserCurrentLocation().then((value) async {
     lat = value.latitude;
      lng = value.longitude;
    });
     dateinput.text = "";
    super.initState();

  }
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController(); 
@override
Widget build(BuildContext context) {
	return Scaffold(
  key: _scaffoldKey,
	endDrawer: Drawer(
      child: Column(
       
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50),
            height: 250,
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Shide',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(''),

           ], ), ), ),
          ListView(
             shrinkWrap: true,
            children: [
             
              ListTile(
                leading: const Icon(Icons.person_2_rounded),
                title: const Text('Passenger'),
                onTap: () {
                 setState(() {

                    usermode = true;
                  
                 });
                 Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.drive_eta_rounded),
                title: const Text('Driver'),
                onTap: () {
                 setState(() {

                    usermode = false;
                  
                 });
                 Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.request_quote),
                title: const Text('Ride Requests'),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text('Ride History'),
                onTap: () {
                  Navigator.pushNamed(context, '/logout');
                },
              ),
              ListTile(
                leading: const Icon(Icons.monetization_on),
                title: const Text('Payments'),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ],
          ),
        ],
      ),
  ),
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
        bottom: usermode? 230 : 330,
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
		child: const Icon(Icons.gps_fixed),
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
                      margin: const EdgeInsets.only(top: 55, left: 170, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      usermode ?
                          Container(
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
                          )

                        
                        :  Container(
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
                         const Spacer(),

                                   Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                     child: InkWell(
                                                               child: const Icon(
                                                                 Icons.menu,
                                                                 color: Colors.white,
                                                                 size: 30,
                                                               ),
                                                               onTap: () {
                                                                // signOut();
                                                                  _scaffoldKey.currentState!.openEndDrawer();
                                                              
                                                               
                                                               },
                                                             ),
                                   )
                        ],
                      ),
                    ),
 
    )
   ),
   usermode ?
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
                      margin: const EdgeInsets.only(left: 40,top: 20),
                      height: 15,
                      width: 15,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        
                      )),
            
             
                    Container(margin: const EdgeInsets.only(left: 40,),
                    height: 60,
                    width: 2,
                    color: Colors.white,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 40),
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
                       margin: const EdgeInsets.only(left: 20, top: 20),
                                 //     height: height * 0.05,
                                  //    width: width * 0.4,
                                  height: 40,
                                  width: 290,
                                      child: TextField(
                                        style: const TextStyle(color: Colors.white),
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
                                           

                                      focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 3.0,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 3.0,
                                                ),
                                              ),
                                          border: OutlineInputBorder(
                                          
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                               
                                          ),
                                        ),

                                        keyboardType: TextInputType.text,
                                        onTap: () {
                                          nextScreen(context, NavigationScreen(lat, lng) );
                                        },
                                        // validator: (String? value) {
                                        //   if (value!.length != 9)
                                        //     return "enter valied phone number";
                                        //   // return null;
                                        // },
                                      ),
                                    ),
            
            
             
                 const SizedBox(height: 13,),
                 
                  Container(
                       margin: const EdgeInsets.only(left: 20, top: 15),
                                 //     height: height * 0.05,
                                  //    width: width * 0.4,
                                  height: 40,
                                  width: 290,
                                      child: TextField(
                                          style: const TextStyle(color: Colors.white),
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
                                          focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 3.0,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
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
             Row(
               children: [
                const Spacer(),

                Icon( Icons.people, color: Colors.white,),
                const SizedBox(width: 10,),
                            SizedBox(
                              height: 30,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FloatingActionButton(
                                       onPressed: () {
                                        setState(() {
                                          seats++;
                                        });
                                       },
                                      backgroundColor: Colors.white,
                                      child: const Icon(Icons.add, color: Colors.black,),),
                            
                                    Text("$seats",
                                        style: const TextStyle(fontSize: 27.0, color: Colors.white)),
                            
                                    FloatingActionButton(
                                      onPressed: () {
                                        setState(() {
                                          if (seats != 1) {
                                            seats--;
                                          }
                                        });
                                      },
                                      child:  const Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                      ),
                                      backgroundColor: Colors.white,),
                                  ],
                                ),
                              ),
                            ),
  
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
                                  
                                        nextScreeniOS(context, const AvailiableRides());
    
                                     
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
                                        child: Text("Search Ride", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),),
                                      ))
                                      ),
                      ),
                    ),
                      const Spacer(),
               ],
             ),
          ],
        )
     ),
   )
    : Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 320,
        width: MediaQuery.of(context).size.width,
  
        //color: Colors.white,
      // margin: EdgeInsets.only(bottom: 30),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red,
                      Colors.orange,
                    ],
                  ),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40), ),
    ), 
      child: 
        Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 40,top: 20),
                      height: 15,
                      width: 15,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        
                      )),
            
             
                    Container(margin: const EdgeInsets.only(left: 40,),
                    height: 60,
                    width: 2,
                    color: Colors.white,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 40),
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
                       margin: const EdgeInsets.only(left: 20, top: 20),
                                 //     height: height * 0.05,
                                  //    width: width * 0.4,
                                  height: 40,
                                  width: 290,
                                      child: TextField(
                                        style: const TextStyle(color: Colors.white),
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
                                           

                                      focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 3.0,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 3.0,
                                                ),
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
            
            
             
                 const SizedBox(height: 13,),
                 
                  Container(
                       margin: const EdgeInsets.only(left: 20, top: 15),
                                 //     height: height * 0.05,
                                  //    width: width * 0.4,
                                  height: 40,
                                  width: 290,
                                      child: TextField(
                                          style: const TextStyle(color: Colors.white),
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
                                          focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 3.0,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
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
          Row(
            children: [
              SizedBox(width: 20,),
              SizedBox(
        //  padding: EdgeInsets.all(15),
              height:40,
              width: 180,
              child:Center( 
                 child:TextField(
                   style: const TextStyle(color: Colors.white),
                    controller: dateinput, //editing controller of this TextField
                   decoration: InputDecoration(
                                            icon: const Icon(Icons.calendar_today, color: Colors.white,),
                                              label: const Text("Enter Date",
                                              
                                              
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                                
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(30.0),
                                                    borderSide: const BorderSide(
                                                      color: Colors.white,
                                                      width: 3.0,
                                                    ),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(30.0),
                                                    borderSide: const BorderSide(
                                                      color: Colors.white,
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
                    readOnly: true,  //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.now(),
                          firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101)
                      );
                      
                      if(pickedDate != null ){
                          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                          print(formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                             dateinput.text = formattedDate; //set output date to TextField value. 
                          });
                      }else{
                          print("Date is not selected");
                      }
                    },
                 ),
              )
        ),
        const SizedBox(width: 20,),
         SizedBox(
        //  padding: EdgeInsets.all(15),
              height:40,
              width: 150,
              child:Center( 
                child:Center( 
             child:TextField(
             style: const TextStyle(color: Colors.white),
                controller: timeinput, //editing controller of this TextField
               decoration: InputDecoration(
                                            icon: const Icon(Icons.timer, color: Colors.white,),
                                              label: const Text("Enter Time",
                                              
                                              
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                                
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(30.0),
                                                    borderSide: const BorderSide(
                                                      color: Colors.white,
                                                      width: 3.0,
                                                    ),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(30.0),
                                                    borderSide: const BorderSide(
                                                      color: Colors.white,
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
                readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
              String? time;
                  TimeOfDay? pickedTime =  await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                      );

                    
                  
                  if(pickedTime != null ){
                      print(pickedTime.format(context));   //output 10:51 PM
                  time=pickedTime.format(context).toString();

                   //   DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                     // print(parsedTime); //output 1970-01-01 22:53:00.000
                      
                  //    String formattedTime = DateFormat('HH:mm').format(parsedTime);
                  //    print(formattedTime); //output 14:59:00
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                     //   timeinput.text = formattedTime; //set the value of text field.
                     timeinput.text = time!; 

                      });
                  }else{
                      print("Time is not selected");
                  }
                },
             )
          )
              )
        ),
            ],
          ),
            const SizedBox(height: 20,),
             Row(
               children: [
                const Spacer(),
                Text("Availiable Seats", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 30,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    FloatingActionButton(
                                       onPressed: () {
                                        setState(() {
                                          seats++;
                                        });
                                       },
                                      backgroundColor: Colors.white,
                                      child: const Icon(Icons.add, color: Colors.black,),),
                            
                                    Text("$seats",
                                        style: const TextStyle(fontSize: 27.0, color: Colors.white)),
                            
                                    FloatingActionButton(
                                      onPressed: () {
                                        setState(() {
                                          if (seats != 1) {
                                            seats--;
                                          }
                                        });
                                      },
                                      child:  const Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                      ),
                                      backgroundColor: Colors.white,),
                                  ],
                                ),
                              ),
                            ),
  
               
                      const Spacer(),
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
                                  
                                        nextScreeniOS(context, const AvailiableRides());
    
                                     
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
                                        child: Text("Post Ride", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),),
                                      ))
                                      ),
                      ),
                    ),

          ],
        )
    ),

    
  )],
     
    ),

	// on pressing floating action button the camera will take to user current location

	);
}
}
