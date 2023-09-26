import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
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
  }) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      // Call the user's CollectionReference to add a new user
      await users.doc(email).set({
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