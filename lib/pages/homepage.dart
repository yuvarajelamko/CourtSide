import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courtside/widgets/matchdetails.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/navigation_bar.dart';
import '/widgets/side_menu.dart';
import '/widgets/coinwallet.dart';
import '/store/game_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  late User _user;
  late String _username = '';
  late String _email = ' ';

  Future<void> _getUserInfo() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user.email)
        .get();
    if (mounted) {
    setState(() {
      _username = userData['username'];
      _email = _user.email!;
    });
    }
  }

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          Row(
            children: [
              CoinWallet(email: _email),
            ],
          ),
        ],
      ),
      drawer: SideMenu(username: _username, email: _email),
      body: GamesList(),
      bottomNavigationBar: MyBottomNavigationBar(index: selectedIndex),
    );
  }
}
