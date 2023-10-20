import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? first_name;
  String? last_name;

  String? phone_number;
  String? gender;
  String? dp_url;
  
  

  User({
    this.phone_number,
    this.first_name,
    this.last_name,
    this.dp_url,

    this.gender,
  });
    
 


  factory User.fromFirestore(DocumentSnapshot snapshot){
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return User(
      phone_number: d['phone_number'],
      first_name: d['first_name'],
      last_name: d['last_name'],
      dp_url: d['dp_url'],
      gender: d['gender'],


      


    );
  }
}