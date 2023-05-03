import 'package:flutter/material.dart';

import '../widgets/navigation_bar.dart';
import '/widgets/coinwallet.dart';

class MyBets extends StatefulWidget {
  @override
  _MyBetsState createState() => _MyBetsState();
}

class _MyBetsState extends State<MyBets> {
  bool _showOngoingBets = true;

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
          CoinWallet(email: 'user@example.com'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _showOngoingBets = true),
                  style: ElevatedButton.styleFrom(
                    primary: _showOngoingBets ? Colors.blue : null,
                  ),
                  child: const Text('Ongoing Bets'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _showOngoingBets = false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !_showOngoingBets ? Colors.blue : null,
                  ),
                  child: Text('Past Bets'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _showOngoingBets
                ? _buildOngoingBetsSection()
                : _buildPastBetsSection(),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(index: selectedIndex),
    );
  }

  Widget _buildOngoingBetsSection() {
    return Center(
      child: Text('Ongoing Bets'),
    );
  }

  Widget _buildPastBetsSection() {
    return Center(
      child: Text('Past Bets'),
    );
  }
}
