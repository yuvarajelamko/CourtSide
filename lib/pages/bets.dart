import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/navigation_bar.dart';
import '/widgets/coinwallet.dart';

class MyBets extends StatefulWidget {
  @override
  _MyBetsState createState() => _MyBetsState();
  final void Function() checkWinningsCallback;
  MyBets({required this.checkWinningsCallback});

}

class _MyBetsState extends State<MyBets> {
  bool _showOngoingBets = true;
  String _email = '';

  @override
  void initState() {
    super.initState();
    _getCurrentUserEmail();
  }

  Future<void> _getCurrentUserEmail() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      _email = currentUser?.email ?? '';
    });
  }


  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bets'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          CoinWallet(email: _email),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _showOngoingBets = true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    _showOngoingBets ? const Color(0xff343b45) : null,
                  ),
                  child: const Text('Ongoing Bets'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _showOngoingBets = false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    !_showOngoingBets ? const Color(0xff343b45) : null,
                  ),
                  child: const Text('Past Bets'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _showOngoingBets
                ? _buildOngoingBetsSection()
                : _buildPastBetsSection(),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                widget.checkWinningsCallback();
              },
              child: Text('Check Winnings'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(index: selectedIndex),
    );
  }

  Widget _buildOngoingBetsSection() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bets')
          .where('user_email', isEqualTo: _email)
          .where('status', isEqualTo: 'active')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading bets'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final bets = snapshot.data!.docs;

        if (bets.isEmpty) {
          return const Center(child: Text('No ongoing bets found'));
        }

        return ListView.builder(
          itemCount: bets.length,
          itemBuilder: (BuildContext context, int index) {
            final betData = bets[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text('${betData['team']}'),
              subtitle: Text('\$${betData['bet_amount']} - ${betData['status']}'),
              trailing: Text('\$${betData['potential_returns']}'),
            );
          },
        );
      },
    );
  }


  Widget _buildPastBetsSection() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('bets')
          .where('user_email', isEqualTo: _email)
          .where('status', isEqualTo: 'completed')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading bets'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final bets = snapshot.data!.docs;

        if (bets.isEmpty) {
          return const Center(child: Text('No past bets found'));
        }

        return ListView.builder(
          itemCount: bets.length,
          itemBuilder: (BuildContext context, int index) {
            final betData = bets[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text('${betData['team']}'),
              subtitle: Text('\$${betData['bet_amount']} - ${betData['status']}'),
              trailing: Text('\$${betData['potential_returns']}'),
            );
          },
        );
      },
    );
  }

}
