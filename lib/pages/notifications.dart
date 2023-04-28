import 'package:courtside/pages/bets.dart';
import 'package:courtside/pages/standings.dart';
import 'package:flutter/material.dart';

import '../main.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyNotifications(),
    );
  }
}

class MyNotifications extends StatefulWidget {
  const MyNotifications({Key? key}) : super(key: key);

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      // if the second item is tapped
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) => const MyHomePage(),
            transitionDuration: Duration.zero),
      );
    } else if (index == 1) {
      // if the second item is tapped
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) => const MyBets(),
            transitionDuration: Duration.zero),
        // push the new page onto the stack
      );
    } else if (index == 2) {
      // if the second item is tapped
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) => const MyStanding(),
            transitionDuration: Duration.zero),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor: Colors.black,

        title: const Text('courtside'),
        automaticallyImplyLeading: false, // set this to false
      ),
      body: const Center(),
      backgroundColor: Colors.black,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
        ),
        child: BottomNavigationBar(
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
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff43F5BF),
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
