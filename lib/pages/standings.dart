import 'package:courtside/pages/bets.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'notifications.dart';

class MyStanding extends StatelessWidget {
  const MyStanding({Key? key}) : super(key: key);

  static const int FirstColumn = 8;
  static const int SecondColumn = 4;
  static const int ThirdColumn = 2;
  static const int LastColumn = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Playoff Standings"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    Container(margin: const EdgeInsets.all(10), child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)), onPressed: () {}, child: const Text("First 16"), )),
                    Container(margin: const EdgeInsets.all(10), child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)), onPressed: () {}, child: const Text("Quarter Finals"), )),
                    Container(margin: const EdgeInsets.all(10), child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)), onPressed: () {}, child: const Text("Semi Finals"), )),
                    Container(margin: const EdgeInsets.all(10), child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)), onPressed: () {}, child: const Text("Finals"), )),


                    // Container(margin: const EdgeInsets.all(10), color: Colors.red, width:30)],
                  ]
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
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
                                    color: Colors.red,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      const SizedBox(width: 50 ),
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
                                    color: Colors.red,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      const SizedBox(width: 50 ),
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
                                    color: Colors.red,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),

                          );

                        }),
                      ),
                      const SizedBox(width: 50 ),
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
                                    color: Colors.red,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.blue,
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
              BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.paid),
                    label: 'Coin',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.emoji_events),
                    label: 'Trophy',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    label: 'Notification',
                  ),
                ],
              ),
            ]
            );
          },
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}
