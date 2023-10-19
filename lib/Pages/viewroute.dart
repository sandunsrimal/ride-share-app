import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Components/NetworkHelper.dart';
import 'home.dart';



class ViewRoute extends StatefulWidget {
  double? startLat;
    double? startLng;
    double? endLat;
    double? endLng;
   ViewRoute({super.key, this.startLat, this.startLng, this.endLat, this.endLng});


  @override
  State<ViewRoute> createState() => _ViewRouteState();
}


 
class _ViewRouteState extends State<ViewRoute> {
@override
  void initState() {
    super.initState();
    setMarkers();
    getJsonData();
   
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

 final List<LatLng> polyPoints = []; // For holding Co-ordinates as LatLng
  final Set<Polyline> polyLines = {}; // For holding instance of Polyline
  final Set<Marker> markers = {}; 
  CameraPosition _kGoogle = CameraPosition(
	target: LatLng(7.8731, 80.7718),
	zoom: 8,
);
  GoogleMapController? mapController;
    setMarkers() {
  
    markers.add(
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(widget.startLat!, widget.startLng!),
        infoWindow: InfoWindow(
          title: "start location",
          snippet: "start location",
        ),
      ),
    );

    markers.add(Marker(
        markerId: MarkerId('2'),
        position: LatLng(widget.endLat!, widget.endLng!),
        infoWindow: InfoWindow(
          title: "end location",
          snippet: "destination",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)));
    
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
        polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }

      if (polyPoints.length == ls.lineString.length) {
        setPolyLines();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Route'),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: GoogleMap(
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
    );
  }
}