import 'package:cloud_firestore/cloud_firestore.dart';

class Requests {
   String? ppnumber;
   String? dpnumber;
   double? fromlatitude;
   double? fromlongitude;
   double? tolatitude;
   double? tolongitude;
   double? rfromlat;
   double? rfromlng;
   double? rtolat;
   double? rtolng;
   int numofpassengers;
   String? price;
   int timestamp;
   String? status;

  Requests({
    this.ppnumber,
    this.dpnumber,
    this.fromlatitude,
    this.fromlongitude,
    this.tolatitude,
    this.tolongitude,
    this.rfromlat,
    this.rfromlng,
    this.rtolat,
    this.rtolng,
    required this.numofpassengers,
    required this.timestamp,
    this.price,
    this.status,
   
  });
    
 


  factory Requests.fromFirestore(DocumentSnapshot snapshot){
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return Requests(
      ppnumber: d['ppnumber'],
      dpnumber: d['dpnumber'],
      fromlatitude: d['fromlatitude'],
      fromlongitude: d['fromlongitude'],
      tolatitude: d['tolatitude'],
      tolongitude: d['tolongitude'],
      rfromlat: d['rfromlat'],
      rfromlng: d['rfromlng'],
      rtolat: d['rtolat'],
      rtolng: d['rtolng'],
      numofpassengers: d['numofpassengers'],
      price: d['price'],
      timestamp: d['timestamp'],
      status: d['status'],


    );
  }
}