import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BalanceScreen extends StatefulWidget {
  final String dpNum;

  BalanceScreen(this.dpNum);

  @override
  _BalanceScreenState createState() => _BalanceScreenState(dpNum);
}

class _BalanceScreenState extends State<BalanceScreen> {
  final String dpNum;

  _BalanceScreenState(this.dpNum);

  double userBalance = 0.0; // Initialize with a default value.
  double percentage = 0.05;

  @override
  void initState() {
    super.initState();
    // Fetch the balance from Firestore based on your criteria.
    _fetchBalance();
  }

  void _fetchBalance() async {
    try {
      final firestoreInstance = FirebaseFirestore.instance;

      final query = await firestoreInstance
          .collection('requests')
          .where('dpnumber', isEqualTo: dpNum)
          .where('status', isEqualTo: 'completed')
          .get();

      double balance = 0.0;

      for (var doc in query.docs) {
        final data = doc.data();
        if (data.containsKey('price')) {
          final priceAsString = data['price'] as String;
          final price = double.tryParse(priceAsString);
          if (price != null) {
            balance += price;
          }
        }
      }

      setState(() {
        userBalance = balance * percentage;
      });
    } catch (error) {
      print('Error fetching balance: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your Balance: Rs:${userBalance.toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.red,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                  updateStatusForPhoneNumber(dpNum);
                  setState(() {
                    userBalance=0.0;
                  });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                minimumSize: Size(200, 60),
              ),
              child: Text(
                'Pay',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // Change the color to your desired color.
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> updateStatusForPhoneNumber(String dpNum) async {
  try {
    final firestoreInstance = FirebaseFirestore.instance;
    final query = await firestoreInstance
        .collection('requests')
        .where('dpnumber', isEqualTo: dpNum)
        .where('status', isEqualTo: 'completed')
        .get();

    for (var doc in query.docs) {
      await firestoreInstance
          .collection('requests')
          .doc(doc.id)
          .update({'status': 'completed and paid'});
    }
    // Perform any additional actions, such as updating the UI, after the update.
  } catch (error) {
    print('Error updating status: $error');
  }
}
