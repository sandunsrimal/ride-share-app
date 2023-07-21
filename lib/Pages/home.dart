import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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
   var dat;
   final List<LatLng> polyPoints = []; 
     final Set<Polyline> polyLines = {}; 

  //  void getPolyPoints () async {
  //   PolylinePoints polylinePoints = PolylinePoints () ;
  //   PolylineResult result = 
  //  }

   @override
  void initState() {
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
      print("object 1");
      dat = await network.getData();

      // We can reach to our desired JSON data manually as following
      LineString ls = LineString(dat['features'][0]['geometry']['coordinates']);

      for (int i = 0; i < ls.lineString.length; i++) {
        polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }

      if (polyPoints.length == ls.lineString.length) {
      print("object 2");

        setPolyLines();
      }
    } catch (e) {
      print(e);
    }
  }

  setPolyLines() {
      print("object 3");

    Polyline polyline = Polyline(
      polylineId: PolylineId("polyline"),
      color: Color(0xff0059c8),
      points: polyPoints,
      width: 5,
    );
      print("object 4");

    polyLines.add(polyline);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: sourcelocation, zoom: 14), 
        markers: {
          Marker(markerId: const MarkerId('Source'),
          position: sourcelocation,
          ),
           Marker(markerId: const MarkerId('Destination'),
          position: destination,
          )
      },),
    );
  }
  

  
}
class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}