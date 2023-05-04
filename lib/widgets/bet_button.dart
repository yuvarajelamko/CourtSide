import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../store/api_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class BetButton extends StatefulWidget {
  final Game game;
  BetButton(this.game);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  _BetButtonState createState() => _BetButtonState();
}

class _BetButtonState extends State<BetButton> {
  bool _showBetDialog = false;
  bool _showConfirmation = false;
  String? _selectedTeam;
  double? _betAmount;
  double? _potentialReturns;

  void _showBetDialogHandler() {
    setState(() {
      _showBetDialog = true;
    });
  }

  void _hideBetDialogHandler() {
    setState(() {
      _showBetDialog = false;
      _selectedTeam = null;
      _betAmount = null;
      _potentialReturns = null;
    });
  }

  Future<void> _deductCoins(double amount) async {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;
    final userRef = FirebaseFirestore.instance.collection('users').doc(email);

    try {
      final userData = await userRef.get();
      final data = userData.data();
      if (data != null) {
        final coinBalance = data['balance'] ?? 0;
        if (coinBalance >= amount) {
          final updatedCoinBalance = coinBalance - amount;
          await userRef.update({'balance': updatedCoinBalance});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Insufficient coins'),
          ));
          throw Exception('Insufficient coins');
        }
      } else {
        throw Exception('User data not found');
      }
    } catch (e) {
      print('Error deducting coins: $e');
      throw e;
    }
  }


  void _betHandler() async {
    if (_selectedTeam == null || _betAmount == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select a team and enter a bet amount'),
      ));
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      final email = user?.email;
      final userRef = FirebaseFirestore.instance.collection('users').doc(email);
      final userData = await userRef.get();
      final data = userData.data();
      if (data != null) {
        final coinBalance = data['balance'] ?? 0;
        if (coinBalance >= _betAmount!) {
          await _deductCoins(_betAmount!);

          // Get a reference to the "bets" collection in Firestore
          final betsRef = FirebaseFirestore.instance.collection('bets');

          // Create a new bet document
          final newBetDoc = betsRef.doc();

          // Get the current date and time
          final now = DateTime.now();

          // Create a new bet object
          final newBet = {
            'id': newBetDoc.id,
            'user_email': FirebaseAuth.instance.currentUser!.email,
            'game_id': widget.game.id,
            'team': _selectedTeam!,
            'bet_amount': _betAmount!,
            'potential_returns': _potentialReturns!,
            'created_at': DateFormat('yyyy-MM-dd HH:mm:ss').format(now),
            'status': 'active',
          };

          // Add the new bet to Firestore
          await newBetDoc.set(newBet);

          // Show a confirmation message
          setState(() {
            _showConfirmation = true;
            _showBetDialog = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Insufficient coins'),
          ));
        }
      } else {
        throw Exception('User data not found');
      }
    } catch (e) {
      print('Error placing bet: $e');
      throw e;
    }
  }





  void _awardCoins(double amount) async {
      final user = FirebaseAuth.instance.currentUser;
      final email = user?.email;
      final userRef = FirebaseFirestore.instance.collection('users').doc(email);

      try {
        final userData = await userRef.get();
        final coinWallet = userData['coin_wallet'] ?? 0;
        final updatedCoinWallet = coinWallet + amount;
        await userRef.update({'coin_wallet': updatedCoinWallet});
      } catch (e) {
        print('Error awarding coins: $e');
      }
    }



  void _confirmHandler() async {
    final updatedGame = await ApiStore.getGame(widget.game.id);
    if (updatedGame.status == 'closed') {
      if (updatedGame.homePoints > updatedGame.awayPoints) {
        if (_selectedTeam == updatedGame.homeTeamAlias) {
          _awardCoins(_betAmount! * _getOdds(updatedGame.homeTeamSeed));
        }
      } else if (updatedGame.awayPoints > updatedGame.homePoints) {
        if (_selectedTeam == updatedGame.awayTeamAlias) {
          _awardCoins(_betAmount! * _getOdds(updatedGame.awayTeamSeed));
        }
      } else {
        _awardCoins(_betAmount!);
      }
      setState(() {
        _showConfirmation = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('The game is still in progress. Please wait for the result.'),
      ));
    }
  }
  double _getOdds(int seed) {
    // Determine the probability of winning based on seed
    double probability = 1.0 / seed;

    // Adjust for home-field advantage if applicable
    if (widget.game.homeTeamSeed == seed) {
      probability *= 1.2;
    } else if (widget.game.awayTeamSeed == seed) {
      probability *= 0.8;
    }

    // Calculate the odds as the reciprocal of the probability
    return 1.0 / probability;
  }

  @override
  Widget build(BuildContext context) {
    final homeTeamOdds = _getOdds(widget.game.homeTeamSeed);
    final awayTeamOdds = _getOdds(widget.game.awayTeamSeed);

    return Column(
      children: [
      ElevatedButton(
      onPressed: _showBetDialogHandler,
      child: Text('Bet'),
    ),
    if (_showBetDialog)
    Dialog(
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
    'Place a Bet',
    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    ),
    ),
    Divider(),
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Text(widget.game.homeTeamAlias),
    Text('vs'),
    Text(widget.game.awayTeamAlias),
    ],
    ),
    ),
    Divider(),
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
    children: [
    Text('Choose a team'),
    SizedBox(height: 8.0),
    DropdownButton<String>(     items: [
    DropdownMenuItem<String>(
    value: widget.game.homeTeamAlias,
    child: Text(widget.game.homeTeamAlias),
    ),
    DropdownMenuItem<String>(
    value: widget.game.awayTeamAlias,
    child: Text(widget.game.awayTeamAlias),
    ),
    ],
    onChanged: (value) {
    setState(() {
    _selectedTeam = value;
    _potentialReturns = _betAmount! * _getOdds(_selectedTeam == widget.game.homeTeamAlias ? widget.game.homeTeamSeed : widget.game.awayTeamSeed);
    });
    },
    value: _selectedTeam,
    hint: Text('Select a team'),
    ),
    SizedBox(height: 8.0),
    Text('Bet amount'),
    SizedBox(height: 8.0),

    SingleChildScrollView(child :    TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'Enter your bet amount',
        prefixIcon: Icon(Icons.attach_money),
      ),
      onChanged: (value) {
        setState(() {
          _betAmount = double.tryParse(value);
          _potentialReturns = _betAmount! * _getOdds(_selectedTeam == widget.game.homeTeamAlias ? widget.game.homeTeamSeed : widget.game.awayTeamSeed);
        });
      },
    ),),

    SizedBox(height: 8.0),
    Text(_potentialReturns != null ? 'Potential Returns: ${NumberFormat.currency(locale: 'en_US', symbol: 'C').format(_potentialReturns!)}' : ''),
    SizedBox(height: 16.0),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    ElevatedButton(
    onPressed: _hideBetDialogHandler,
    child: Text('Cancel'),
    ),
    ElevatedButton(
    onPressed: _betAmount != null && _selectedTeam != null ? _betHandler : null,
    child: Text('Bet'),
    ),
    ],
    ),
    SizedBox(height: 16.0),
    ],
    ),
    ),
    ]
    ),
    ),
    if (_showConfirmation)
    Dialog(
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
    'Confirmation',
    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    ),
    ),
    Divider(),
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
    'You have placed a bet of ${NumberFormat.currency(locale: 'en_US', symbol: 'C').format(_betAmount!)} on ${_selectedTeam == widget.game.homeTeamAlias ? widget.game.homeTeamAlias : widget.game.awayTeamAlias}'),
    ),
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
    onPressed: _confirmHandler,
    child: Text('Confirm'),
    ),
    ),
    ],
    ),
    ),
    ],
    );
  }
}
