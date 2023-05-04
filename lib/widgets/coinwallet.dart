import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoinWallet extends StatelessWidget {
  final String email;

  CoinWallet({required this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          final coinBalance = data != null ? data['balance'] ?? 0 : 0;
          return Row(
            children: [
              Text(
                'Available Balance: ',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '$coinBalance coins',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(email)
                      .update({'balance': 1000});
                },
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
