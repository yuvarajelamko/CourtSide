import 'package:flutter/material.dart';
import '../pages/bets.dart';
import '../pages/homepage.dart';
import '../pages/notifications.dart';
import '../pages/standings.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key, required this.index})
      : super(key: key);

  final int index;

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  void _onItemTapped(int index) {
    switch (index) {
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
          icon: Center(
            child: Icon(Icons.home,
                size: widget.index == 0 ? 30 : 25,
                color:
                    widget.index == 0 ? const Color(0xff43F5BF) : Colors.grey),
          ),
          label: widget.index == 0 ? 'Home' : '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.paid,
              size: widget.index == 1 ? 30 : 25,
              color: widget.index == 1 ? const Color(0xff43F5BF) : Colors.grey),
          label: widget.index == 1 ? 'Bets' : ' ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events,
              size: widget.index == 2 ? 30 : 25,
              color: widget.index == 2 ? const Color(0xff43F5BF) : Colors.grey),
          label: widget.index == 2 ? 'Standings' : ' ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications,
              size: widget.index == 3 ? 30 : 25,
              color: widget.index == 3 ? const Color(0xff43F5BF) : Colors.grey),
          label: widget.index == 3 ? 'Notifications' : ' ',
        ),
      ],
      currentIndex: widget.index,
      selectedItemColor: const Color(0xff43F5BF),
      unselectedItemColor: Colors.grey,
      onTap: (int index) => _onItemTapped(index),
    );
  }
}
