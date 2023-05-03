import 'package:cloud_firestore/cloud_firestore.dart';
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
              IconButton(
                icon: const Icon(FontAwesomeIcons.medal),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Leaderboard()),
                  );
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
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          title: const Center(
                            child: Text(
                              'H vs A',
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 200,
                            child: SingleChildScrollView(
                              child: Stack(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 180,
                                          child: Column(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.all(0),
                                                child: Center(
                                                    child: Text('"Odd H"')),
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 180,
                                          child: Column(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.all(0),
                                                child: Center(
                                                    child: Text('"Odd A"')),
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 60,
                                    left: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'Enter your bet amount:',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              height: 40,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 0,
                                    right: 0,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 80,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            backgroundColor: Colors.black,
                                            foregroundColor:
                                                const Color(0xff43f5bf),
                                          ),
                                          child: const Text('Bet'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Align(
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
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          title: const Center(
                            child: Text(
                              'H vs A',
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 200,
                            child: SingleChildScrollView(
                              child: Stack(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 180,
                                          child: Column(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.all(0),
                                                child: Center(
                                                    child: Text('"Odd H"')),
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 180,
                                          child: Column(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.all(0),
                                                child: Center(
                                                    child: Text('"Odd A"')),
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 60,
                                    left: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'Enter your bet amount:',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              height: 40,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 0,
                                    right: 0,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 80,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            backgroundColor: Colors.black,
                                            foregroundColor:
                                                const Color(0xff43f5bf),
                                          ),
                                          child: const Text('Bet'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Align(
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
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          title: const Center(
                            child: Text(
                              'H vs A',
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 200,
                            child: SingleChildScrollView(
                              child: Stack(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 180,
                                          child: Column(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.all(0),
                                                child: Center(
                                                    child: Text('"Odd H"')),
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 180,
                                          child: Column(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.all(0),
                                                child: Center(
                                                    child: Text('"Odd A"')),
                                              ),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 60,
                                    left: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'Enter your bet amount:',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              height: 40,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 0,
                                    right: 0,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: 80,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            backgroundColor: Colors.black,
                                            foregroundColor:
                                                const Color(0xff43f5bf),
                                          ),
                                          child: const Text('Bet'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Align(
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
                ),
              ],
            )),
      ),
      bottomNavigationBar: MyBottomNavigationBar(index: selectedIndex),
    );
  }
}
