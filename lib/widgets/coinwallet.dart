import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoinWallet extends StatefulWidget {
  final String email;

  CoinWallet({required this.email});

  @override
  _CoinWalletState createState() => _CoinWalletState();
}

class _CoinWalletState extends State<CoinWallet> {
  int _coinBalance = 0;

  @override
  void initState() {
    super.initState();
    _getCoinBalance();
  }

  void _getCoinBalance() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.email)
        .get();
    if (snapshot.exists) {
      setState(() {
        _coinBalance = snapshot.data()!['balance'];
      });
    }
  }

  void _resetBalance() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.email)
        .update({'balance': 1000});
    setState(() {
      _coinBalance = 1000;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Available Balance: ',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          '$_coinBalance coins',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: _resetBalance,
        ),
      ],
    );
  }
}
