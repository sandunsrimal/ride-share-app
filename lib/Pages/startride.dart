import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../Components/NetworkHelper.dart';
import '../Utils/next_screen.dart';

import 'home.dart';



class ViewRoute extends StatefulWidget {
    double? startLat;
    double? startLng;
    double? endLat;
    double? endLng;

    double? pslat;
    double? pslng;
    double? ptlat;
    double? ptlng;
   ViewRoute({super.key, this.startLat, this.startLng, this.endLat, this.endLng, this.pslat, this.pslng, this.ptlat, this.ptlng});


  @override
  State<ViewRoute> createState() => _ViewRouteState();
}


 
class _ViewRouteState extends State<ViewRoute> {
@override
  void initState() {
    super.initState();
    setMarkers();
    getJsonData();
    getJsonDatap();
    getJsonDatal();
    
   
  }

    setPolyLines() {
    Polyline polyline = Polyline(
      polylineId: PolylineId("polyline"),
      color: Color.fromARGB(255, 0, 90, 200),
      points: polyPoint1,
      width: 5,
    );
    //polyLines.add(polyline);
    setState(() {
      polyLines.add(polyline);
    });
  }

  setPolyLinep() {
    Polyline polyline = Polyline(
      polylineId: PolylineId("polylinep"),
      color: Color.fromARGB(251, 0, 200, 50),
      points: polyPoint2,
      width: 5,
    );
    
    setState(() {
      polyLines.add(polyline);
    });
  }
    setPolyLinel() {
    Polyline polyline = Polyline(
      polylineId: PolylineId("polylinel"),
      color: Color.fromARGB(255, 0, 90, 200),
      points: polyPoint3,
      width: 5,
    );
   
    setState(() {
       polyLines.add(polyline);
    });
  }

 final List<LatLng> polyPoint1 = []; // For holding Co-ordinates as LatLng
 final List<LatLng> polyPoint2 = [];
 final List<LatLng> polyPoint3 = [];
//  final List<LatLng> polyPointp = [];
  final Set<Polyline> polyLines = {}; // For holding instance of Polyline
  final Set<Marker> markers = {}; 
  CameraPosition _kGoogle = CameraPosition(
	target: LatLng(7.8731, 80.7718),
	zoom: 8,
);
  GoogleMapController? mapController;


    setMarkers() async {
    BitmapDescriptor pickup = await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(size: Size(8, 8)),
    "assets/images/pickman.png",
);
    BitmapDescriptor drop = await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(),
    "assets/images/dropman.png",
);
    markers.add(Marker(
        markerId: MarkerId("1"),
        position: LatLng(widget.startLat!, widget.startLng!),
        infoWindow: InfoWindow(
          title: "start location",
          snippet: "start",
          onTap: () async => await launchUrlString(
                     "https://www.google.com/maps/search/?api=1&query=${widget.startLat},${widget.startLng}"),
        ),
        icon: pickup,
      ),
    );

    markers.add(Marker(
        markerId: MarkerId('2'),
        position: LatLng(widget.endLat!, widget.endLng!),
        infoWindow: InfoWindow(
          title: "end location",
          snippet: "des",
        ),
        icon: drop
        
        )
        );

         markers.add(Marker(
        markerId: MarkerId('3'),
        position: LatLng(widget.pslat!, widget.pslng!),
        infoWindow: InfoWindow(
          title: "end location",
          snippet: "destination",
        ),
       // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
        )
        );

         markers.add(Marker(
        markerId: MarkerId('4'),
        position: LatLng(widget.ptlat!, widget.ptlng!),
        infoWindow: InfoWindow(
          title: "end location",
          snippet: "destination",
        ),
       // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
        
        ));
    
  }
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setMarkers();
  }
  var dat;
  void getJsonData() async {
    // Create an instance of Class NetworkHelper which uses http package
    // for requesting data to the server and receiving response as JSON format

    NetworkHelper network = NetworkHelper(
      startLat: widget.pslat!,
      startLng: widget.pslng!,
      endLat: widget.startLat!,
      endLng: widget.startLng!,
      
    );

    try {
      // getData() returns a json Decoded data
      dat = await network.getData();

      // We can reach to our desired JSON data manually as following
      LineString ls = LineString(dat['features'][0]['geometry']['coordinates']);

      for (int i = 0; i < ls.lineString.length; i++) {
        polyPoint1.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }

      if (polyPoint1.length == ls.lineString.length) {
        setPolyLines();
      }
    } catch (e) {
      print(e);
    }
  }

void getJsonDatap() async {
    // Create an instance of Class NetworkHelper which uses http package
    // for requesting data to the server and receiving response as JSON format

    NetworkHelper network = NetworkHelper(
      startLat: widget.startLat!,
      startLng: widget.startLng!,
      endLat: widget.endLat!,
      endLng: widget.endLng!,
      
    );

    try {
      // getData() returns a json Decoded data
      dat = await network.getData();

      // We can reach to our desired JSON data manually as following
      LineString ls = LineString(dat['features'][0]['geometry']['coordinates']);

      for (int i = 0; i < ls.lineString.length; i++) {
        polyPoint2.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }

      if (polyPoint2.length == ls.lineString.length) {
        setPolyLinep();
      }
    } catch (e) {
      print(e);
    }
  }
  void getJsonDatal() async {
    // Create an instance of Class NetworkHelper which uses http package
    // for requesting data to the server and receiving response as JSON format

    NetworkHelper network = NetworkHelper(
      startLat: widget.endLat!,
      startLng: widget.endLng!,
      endLat: widget.ptlat!,
      endLng: widget.ptlng!,
      
    );

    try {
      // getData() returns a json Decoded data
      dat = await network.getData();

      // We can reach to our desired JSON data manually as following
      LineString ls = LineString(dat['features'][0]['geometry']['coordinates']);

      for (int i = 0; i < ls.lineString.length; i++) {
        polyPoint3.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }

      if (polyPoint3.length == ls.lineString.length) {
        setPolyLinel();
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      body: Stack(
        children: [
           GoogleMap(
          initialCameraPosition: _kGoogle,
          //   mapType: MapType.terrain,
          onMapCreated: _onMapCreated,
          // markers: markers,
          polylines: polyLines,
          //  onMapCreated: (controller) => onMapCreated(controller),
          markers: Set.from(markers),
          // polylines: Set<Polyline>.of(polylines.values),
          compassEnabled: true,
          myLocationEnabled: true,
          //    zoomGesturesEnabled: true,
        ),
         Container(
          margin: EdgeInsets.only(bottom: 30),
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
         width: 180,
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
                 onPressed: ()  {

              

                   //  print(phoneNumberController.text);
                 
                       // nextScreeniOS(context, const AvailiableRides());
    
                      
                   // if (!loading) {
                   //   setState(() {
                   //     index = false;
                   //   });
                   // }

                   // print(phoneNumberController);
                 },
                 child:  const Padding(
                         padding: EdgeInsets.only(
                          
                         ),
                         child: Text("Complete Ride", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),),
                       ))
                       ),
                      ),
                    ),
          Container(
    alignment: Alignment.topCenter,
    child: Container(
      height: 120,
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
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50 ),bottomRight: Radius.circular(50)),
      ),
      child:    Stack(
        children: [
          
          Positioned(
            top: 30,
            left: 15,
            child: Container(
            margin: const EdgeInsets.only(top: 20,left: 10),
            child: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back_ios , color: Colors.white,),
            iconSize: 20,
            onPressed: () {
              polyLines.clear();

              Navigator.of(context).pop();
            },
          ),
          ),),
          
             Container(
                        margin: const EdgeInsets.only(bottom: 20),
          alignment: Alignment.bottomCenter,
                       child: const Text("Ride",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                      ),

                     
      
        ])
      
 
    )
   ),
   
        ],
        
      ),
    );
  }
}