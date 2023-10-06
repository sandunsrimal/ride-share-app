import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServiceDriver {
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  Future<String?> addUser({
    required String firstname,
    required String lastname,
    required String email,
    required String homenumber,
    required String phonenumber,
    required String usertype,
    required String nic,
    required String nicimage,
    required String age,
    required String gender,
    required String accountstatus,
    required String vehicletype,
    required String vehiclenumber,
    required String vehicleimage,
  }) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('drivers');
      // Call the user's CollectionReference to add a new user
      await users.doc("$timestamp").set({
        'first_name': firstname,
        'last_name': lastname,
        'email': email,
        'home_number': homenumber,
        'phone_number': phonenumber,
        'user_type': usertype,
        'nic': nic,
        'nic_image': nicimage,
        'age': age,
        'gender': gender,
        'account_status': accountstatus,
        'vehicle_type': vehicletype,
        'vehicle_number': vehiclenumber,
        'vehicle_image': vehicleimage,
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