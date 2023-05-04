import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/navigation_bar.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  List<DocumentSnapshot> _leaderboard = [];
  int selectedIndex = 3;

  void _getLeaderboard() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('balance', descending: true)
        .limit(10)
        .get();
    setState(() {
      _leaderboard = snapshot.docs;
    });
  }

  @override
  void initState() {
    super.initState();
    _getLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboards'),
        automaticallyImplyLeading: false,
      ),
      body:
      ListView.builder(
        itemCount: _leaderboard.length,
        itemBuilder: (context, index) {
          final user = _leaderboard[index].data() as Map<String, dynamic>;
          final rank = index + 1;
          return ListTile(
            leading: Text('$rank.'),
            title: Text(user['username'] as String), // cast to String type
            trailing: Text('${user['balance']} coins'),
          );
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(index: selectedIndex),
    );
  }
}
