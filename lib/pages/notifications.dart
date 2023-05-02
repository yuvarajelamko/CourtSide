import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/navigation_bar.dart';


class MyNotifications extends StatelessWidget {
  const MyNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('courtside'),
      ),
      body: const Center(
        child: Text('Display notifications'),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
