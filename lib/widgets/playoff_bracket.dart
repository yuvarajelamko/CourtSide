import 'package:flutter/material.dart';

class PlayoffBracket extends StatelessWidget {
  const PlayoffBracket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3, // number of columns in the grid
      children: [
        _buildCell('Team A', 'Team B', 'Team A', Colors.green),
        _buildCell('Team C', 'Team D', '', Colors.grey),
        _buildCell('Team E', 'Team F', '', Colors.grey),
        _buildCell('Team G', 'Team H', '', Colors.grey),
        _buildCell('', '', '', Colors.grey),
        _buildCell('Team I', 'Team J', '', Colors.grey),
        _buildCell('Team K', 'Team L', '', Colors.grey),
        _buildCell('', '', '', Colors.grey),
        _buildCell('', '', '', Colors.grey),
        _buildCell('Team M', 'Team N', '', Colors.grey),
        _buildCell('Team O', 'Team P', '', Colors.grey),
        _buildCell('', '', '', Colors.grey),
        _buildCell('', '', '', Colors.grey),
        _buildCell('', '', '', Colors.grey),
        _buildCell('Team Q', 'Team R', '', Colors.grey),
      ],
    );
  }

  Widget _buildCell(String team1, String team2, String winner, Color color) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(team1),
          SizedBox(height: 8),
          Text(team2),
          SizedBox(height: 8),
          Text(winner),
        ],
      ),
    );
  }
}
