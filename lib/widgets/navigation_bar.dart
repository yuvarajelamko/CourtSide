import 'package:flutter/material.dart';
import '../pages/bets.dart';
import '../pages/homepage.dart';
import '../pages/notifications.dart';
import '../pages/standings.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch(index) {
      case 0:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) => const MyHomePage(),
            transitionDuration: Duration.zero,
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, anim1, anim2) => const MyBets(),
              transitionDuration: Duration.zero),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, anim1, anim2) => const MyStanding(),
              transitionDuration: Duration.zero),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, anim1, anim2) => const MyNotifications(),
              transitionDuration: Duration.zero),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: _selectedIndex == 0 ? const Color(0xff43F5BF) : Colors.grey),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.paid, color: _selectedIndex == 1 ? const Color(0xff43F5BF) : Colors.grey),
          label: 'Bets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events, color: _selectedIndex == 2 ? const Color(0xff43F5BF) : Colors.grey),
          label: 'Standings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications, color: _selectedIndex == 3 ? const Color(0xff43F5BF) : Colors.grey),
          label: 'Notifications',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xff43F5BF),
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }
}
