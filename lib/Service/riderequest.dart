import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServiceRequest {
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  Future<String?> sendRequest({
    required String ppnumber,
    required String dpnumber,
    required double fromlatitude,
    required double fromlongitude,
    required double tolatitude,
    required double tolongitude,
    required double rfromlat,
    required double rfromlng,
    required double rtolat,
    required double rtolng,
    required int numofpassengers,
    required String price,
    required String status,
   
  }) async {
    try {
      CollectionReference requests =
          FirebaseFirestore.instance.collection('requests');
      // Call the user's CollectionReference to add a new user
      await requests.doc("$timestamp").set({
        'ppnumber': ppnumber,
        'dpnumber': dpnumber,
        'fromlatitude': fromlatitude,
        'fromlongitude': fromlongitude,
        'tolatitude': tolatitude,
        'tolongitude': tolongitude,
        'numofpassengers': numofpassengers,
        'price': price,
        'rfromlat': rfromlat,
        'rfromlng': rfromlng,
        'rtolat': rtolat,
        'rtolng': rtolng,
        'status': status,
        'timestamp': timestamp,

      });
      return 'success';
    } catch (e) {
      return 'Error adding request';
    }
  }

  Future<String?> getUser(String email) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('requests');
      final snapshot = await users.doc(email).get();
      final data = snapshot.data() as Map<String, dynamic>;
      return data['full_name'];
    } catch (e) {
      return 'Error fetching user';
    }
  }
}