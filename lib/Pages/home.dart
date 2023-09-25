import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Components/NetworkHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Completer<GoogleMapController> _controller = Completer();
   LatLng sourcelocation= const LatLng(6.976086, 79.915878);
   LatLng destination= const LatLng(6.970172, 79.904951);
   double? lat;
   double? lng;
   var dat;
   final List<LatLng> polyPoints = []; 
     final Set<Polyline> polyLines = {}; 

  //  void getPolyPoints () async {
  //   PolylinePoints polylinePoints = PolylinePoints () ;
  //   PolylineResult result = 
  //  }


   @override
  void initState() {
    getCurrentLocation();
    getJsonData();
    
    super.initState();
    
  }
    void getJsonData() async {
    // Create an instance of Class NetworkHelper which uses http package
    // for requesting data to the server and receiving response as JSON format

    NetworkHelper network = NetworkHelper(
      startLat: sourcelocation.latitude,
      startLng: sourcelocation.longitude,
      endLat: destination.latitude,
      endLng: destination.longitude,
    );

    try {
      // getData() returns a json Decoded data
   
      dat = await network.getData();

      // We can reach to our desired JSON data manually as following
      LineString ls = LineString(dat['features'][0]['geometry']['coordinates']);

      for (int i = 0; i < ls.lineString.length; i++) {
        polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }

      if (polyPoints.length == ls.lineString.length) {
     

        setPolyLines();
      }
    } catch (e) {
      print(e);
    }
  }

  setPolyLines() {
    

    Polyline polyline = Polyline(
      polylineId: PolylineId("polyline"),
      color: Color(0xff0059c8),
      points: polyPoints,
      width: 5,
    );
     

    polyLines.add(polyline);
    setState(() {});
  }

    Future getCurrentLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = geoposition.latitude;
      lng = geoposition.longitude;
      
   //   location = '${geoposition.latitude}, ${geoposition.longitude}';
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     
      body: Column(
        children: [
          Stack(
           
            children: [
              SizedBox(
                 height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  mapType: MapType.normal,

                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  initialCameraPosition: CameraPosition(target: LatLng(lat!, lng!), zoom: 9),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: {
                  Marker(markerId: const MarkerId('Source'),
                  position: sourcelocation,
                  ),
                   Marker(markerId: const MarkerId('Destination'),
                  position: destination,
                  ),
                  // Marker(markerId: const MarkerId('Current'),
                  // position: LatLng(lat!, lng!),)
                      },
                      polylines: polyLines,
                ),
              ),
              Positioned(
                top: 50,
                left: 10,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      )
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Positioned(
             bottom: 0,
            child: Container(
              
              height: 350,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, -5),
                  )
                ],
              ),
            
          )),
              
            ],
          ),
        ],
      ),
      
    );
  }
  

  
}
class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}