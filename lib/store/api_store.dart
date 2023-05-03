import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Game> getData(String dataType) async {
  //daily schedules: games/:year/:month/:day/schedule.json?api_key= (refer to the API Sandbox);
  //game summary: games/:game_id/boxscore:format (refer to the API Sandbox);
  late String gameTitle = '';
  late String gameStatus = '';
  late String typeURL;
  const String apiKey = 'rkcd9u7zu893xzms99pdmxtf';
  if (dataType == 'dailySchedules') {
    typeURL = 'games/2023/04/26/schedule.json?api_key=$apiKey';
  }

  String apiUrl = 'http://api.sportradar.us/nba/trial/v8/en/$typeURL';

  var response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    var games = jsonData['games'];

    for (var game in games) {
      gameTitle = game['title'];
      gameStatus = game['status'];
    }

    Game game = Game(gameTitle, gameStatus);
    return game;
  } else {
    throw Exception("Failed to load");
  }
}

class Game {
  late String title = '';
  late String status = '';
  Game(this.title, this.status);
}