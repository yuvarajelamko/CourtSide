import 'package:courtside/pages/bets.dart';
import 'package:flutter/material.dart';
import '../widgets/navigation_bar.dart';
import 'homepage.dart';
import 'notifications.dart';
import 'package:courtside/main.dart';

class MyStanding extends StatefulWidget {
  const MyStanding({Key? key}) : super(key: key);

  @override
  _MyStandingState createState() => _MyStandingState();
}

class _MyStandingState extends State<MyStanding> {
  int selectedIndex = 2;
  final ScrollController _scrollController = ScrollController();

  static const int FirstColumn = 8;
  static const int SecondColumn = 4;
  static const int ThirdColumn = 2;
  static const int LastColumn = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Playoff Standings"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    _scrollController.animateTo(
                      FirstColumn * 0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text("First 16"),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    _scrollController.animateTo(
                      FirstColumn * 1 + SecondColumn * 65,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text("Quarter Finals"),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    _scrollController.animateTo(
                      (FirstColumn + SecondColumn) * 50,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text("Semi Finals"),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {
                    _scrollController.animateTo(
                      (FirstColumn + SecondColumn + ThirdColumn) * 59.8,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text("Finals"),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    Column(
                      children: List.generate(FirstColumn, (index) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          width: 250,
                          height: 100,
                          color: Colors.black,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.teal,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: const Color(0xff343b45),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(width: 50),
                    Column(
                      children: List.generate(SecondColumn, (index) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          width: 250,
                          height: 100,
                          color: Colors.black,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.teal,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: const Color(0xff343b45),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(width: 50),
                    Column(
                      children: List.generate(ThirdColumn, (index) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          width: 250,
                          height: 100,
                          color: Colors.black,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.teal,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: const Color(0xff343b45),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(width: 50),
                    Column(
                      children: List.generate(LastColumn, (index) {
                        return Container(
                          margin: const EdgeInsets.all(10),
                          width: 250,
                          height: 100,
                          color: Colors.black,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.teal,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: const Color(0xff343b45),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(index: selectedIndex),
    );
  }
}
