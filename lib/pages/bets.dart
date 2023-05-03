import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/navigation_bar.dart';

class MyBets extends StatelessWidget {
  const MyBets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('courtside'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Display Betting Info'),
      ),
      bottomNavigationBar: MyBottomNavigationBar(index: selectedIndex),
    );
  }
}
