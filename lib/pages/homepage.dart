import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courtside/pages/bets.dart';
import 'package:courtside/pages/notifications.dart';
import 'package:courtside/pages/standings.dart';
import 'package:courtside/widgets/matchdetails.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/navigation_bar.dart';
import '/widgets/side_menu.dart';
import '/widgets/leaderboard.dart';
import '/widgets/coinwallet.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late User _user;
  late String _username = '';
  late String _email = ' ';


  Future<void> _getUserInfo() async {
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(_user.email).get();
    setState(() {
      _username = userData['username'];
      _email = _user.email!;
    });
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
              IconButton(
                icon: const Icon(FontAwesomeIcons.medal),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Leaderboard()),);
                },
              ),
            ],
          ),
        ],
      ),
      drawer: SideMenu(username: _username, email: _email),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyMatchDetails()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width *
                        0.9, // set width as 90% of screen width
                    height: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xff343b45),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Text(
                      '"ongoing matches"',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.9, // set width as 90% of screen width,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xff343b45),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '"next matches"',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.9, // set width as 90% of screen width,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xff343b45),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '"next matches',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.9, // set width as 90% of screen width,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xff343b45),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '"next matches',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
//
