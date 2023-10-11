import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  String? first_name;
  String? last_name;
  String? vehicle_type;
  String? vehicle_number;
  String? phone_number;
  String? gender;
  
  

  Driver({
    this.phone_number,
    this.first_name,
    this.last_name,
    this.vehicle_type,
    this.vehicle_number,
    this.gender,
  });
    
 


  factory Driver.fromFirestore(DocumentSnapshot snapshot){
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return Driver(
      phone_number: d['phone_number'],
      first_name: d['first_name'],
      last_name: d['last_name'],
      vehicle_type: d['vehicle_type'],
      vehicle_number: d['vehicle_number'],
      gender: d['gender'],


      


    );
  }
}