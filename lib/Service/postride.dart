import 'package:cloud_firestore/cloud_firestore.dart';

class PostRideService{
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  Future<String?> addUser({
    required String phonenumber,
    required int passengers,
    required double fromlatitude,
    required double fromlongitude,
    required double tolatitude,
    required double tolongitude,
    required String date,
    required String time,

  }) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('rides');
      // Call the user's CollectionReference to add a new user
      await users.doc("$timestamp").set({
        'phone_number': phonenumber,
        'passengers': passengers,
        'from_latitude': fromlatitude,
        'from_longitude': fromlongitude,
        'to_latitude': tolatitude,
        'to_longitude': tolongitude,
        'date': date,
        'time': time,
      });
      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }

  Future<String?> getUser(String email) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final snapshot = await users.doc(email).get();
      final data = snapshot.data() as Map<String, dynamic>;
      return data['full_name'];
    } catch (e) {
      return 'Error fetching user';
    }
  }
}