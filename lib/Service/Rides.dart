import 'package:cloud_firestore/cloud_firestore.dart';

class Rides {
  String? phone_number;
  int? passengers;
  double? from_latitude;
  double? from_longitude;
  double? to_latitude;
  double? to_longitude;
  String? date;
  String? time;
  

  Rides({
    this.phone_number,
    this.passengers,
    this.from_latitude,
    this.from_longitude,
    this.to_latitude,
    this.to_longitude,
    this.date,
    this.time,
  });
    
 


  factory Rides.fromFirestore(DocumentSnapshot snapshot){
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return Rides(
      phone_number: d['phone_number'],
      passengers: d['passengers'],
      from_latitude: d['from_latitude'],
      from_longitude: d['from_longitude'],
      to_latitude: d['to_latitude'],
      to_longitude: d['to_longitude'],
      date: d['date'],
      time: d['time'],


    );
  }
}