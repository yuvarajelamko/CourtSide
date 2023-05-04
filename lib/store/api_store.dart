import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Game {
  final String id;
  final String status;
  final String title;
  final DateTime scheduled;
  final int homePoints;
  final int awayPoints;
  final String homeTeamName;
  final String awayTeamName;
  final String homeTeamAlias;
  final String awayTeamAlias;
  final int homeTeamSeed;
  final int awayTeamSeed;

  Game({
    required this.id,
    required this.status,
    required this.title,
    required this.scheduled,
    required this.homePoints,
    required this.awayPoints,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.homeTeamAlias,
    required this.awayTeamAlias,
    required this.homeTeamSeed,
    required this.awayTeamSeed,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    final scheduledDateTime = DateTime.parse(json['scheduled']);
    final scheduledMalaysia = scheduledDateTime
        .toUtc()
        .add(Duration(hours: 8)); // add 8 hours to convert to Malaysia time

    return Game(
      id: json['id'],
      status: json['status'],
      title: json['title'],
      scheduled: scheduledMalaysia,
      homePoints: json['home_points'] ?? 0,
      awayPoints: json['away_points'] ?? 0,
      homeTeamName: json['home']['name'],
      awayTeamName: json['away']['name'],
      homeTeamAlias: json['home']['alias'],
      awayTeamAlias: json['away']['alias'],
      homeTeamSeed: json['home']['seed'] ?? 0,
      awayTeamSeed: json['away']['seed'] ?? 0,
    );
  }

  String get scheduledMalaysiaFormatted {
    final malaysiaDateFormat =
        DateFormat('EEEE, dd MMMM yyyy, hh:mm a', 'en_MY');
    return malaysiaDateFormat.format(scheduled);
  }
}

class ApiStore {
  static Future<List<Game>> getGames(DateTime date) async {
    final year = date.year;
    final month = date.month;
    final day = date.day;
    final key = '6xa9s4dq6s3n6r382xr86ex6';
    final url = 'http://api.sportradar.us/nba/trial/v8/en/games/$year/$month/$day/schedule.json?api_key=$key';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<Game> games = _parseGamesResponse(response.body);
      return games;
    } else {
      throw Exception('Failed to load games');
    }
  }

  static Future<Game> getGame(String gameId) async {
    // Build the API URL with the gameId parameter

    final key = '6xa9s4dq6s3n6r382xr86ex6';
    final url = 'http://api.sportradar.us/nba/trial/v8/en/games/$gameId/summary.json?api_key=$key';

    // Make the HTTP GET request
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Game game = Game.fromJson(data);
      return game;
    } else {
      throw Exception('Failed to load game');
    }
  }

  static List<Game> _parseGamesResponse(String response) {
    final Map<String, dynamic> data = jsonDecode(response);
    final List<dynamic>? gamesData = data['games'];
    if (gamesData == null) {
      return [];
    }
    final List<Game> games =
        gamesData.map((gameJson) => Game.fromJson(gameJson)).toList();
    return games;
  }
}
