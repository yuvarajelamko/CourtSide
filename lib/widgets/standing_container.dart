import 'package:courtside/store/api_store.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GamesContainer extends StatefulWidget {
  final int numberOfColumn;
  GamesContainer({required this.numberOfColumn});

  @override
  _GamesContainerState createState() => _GamesContainerState();
}

class _GamesContainerState extends State<GamesContainer> {
  String apiKey = 'rkcd9u7zu893xzms99pdmxtf';

  late String? homeAlias;
  late String? homeMarket;
  late String? homeName;
  late int? homeRecord;
  late String? awayAlias;
  late String? awayMarket;
  late String? awayName;
  late int? awayRecord;
  int dataLength = 0;
  dynamic jsonData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    String apiUrl =
        'http://api.sportradar.us/nba/trial/v8/en/series/2022/PST/schedule.json?api_key=$apiKey';
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      setState(() {
        dataLength = jsonData['series'].length;
        homeAlias = jsonData['series'][0]['participants'][0]['team']
                ?['alias'] ??
            'NoAlias';
        homeMarket = jsonData['series'][0]['participants'][0]['team']['market'];
        homeName = jsonData['series'][0]['participants'][0]['team']['name'];
        homeRecord = jsonData['series'][0]['participants'][0]['record'];
        awayAlias = jsonData['series'][0]['participants'][1]['team']['alias'] ??
            'NoAlias';
        awayMarket = jsonData['series'][0]['participants'][1]['team']['market'];
        awayName = jsonData['series'][0]['participants'][1]['team']['name'];
        awayRecord = jsonData['series'][0]['participants'][1]['record'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<GameContainer> gameContainers = [];
    var check = widget.numberOfColumn;
    if (widget.numberOfColumn == 8) {
      for (int i = 0; i < dataLength; i++) {
        if (jsonData['series'][i]['round'] == 1) {
          homeAlias = jsonData['series'][i]['participants'][0]['team']
                  ?['alias'] ??
              'NoAlias';
          homeMarket = jsonData['series'][i]['participants'][0]['team']
                  ?['market'] ??
              'Team A';
          homeName = jsonData['series'][i]['participants'][0]['team']
                  ?['name'] ??
              'NoName';
          homeRecord = jsonData['series'][i]['participants'][0]['record'];
          awayAlias = jsonData['series'][i]['participants'][1]['team']
                  ?['alias'] ??
              'NoAlias';
          awayMarket = jsonData['series'][i]['participants'][1]['team']
                  ?['market'] ??
              'Team B';
          awayName = jsonData['series'][i]['participants'][1]['team']
                  ?['name'] ??
              'NoName';
          awayRecord = jsonData['series'][i]['participants'][1]['record'];

          print('$homeAlias, $awayAlias, $homeRecord, $awayRecord');

          if (homeAlias != 'NoAlias') {
            gameContainers.add(GameContainer(
              homeAlias: homeAlias ?? '',
              homeMarket: homeMarket ?? '',
              homeName: homeName ?? '',
              homeRecord: homeRecord ?? 0,
              awayAlias: awayAlias ?? '',
              awayMarket: awayMarket ?? '',
              awayName: awayName ?? '',
              awayRecord: awayRecord ?? 0,
            ));
          } else if (homeAlias == 'NoAlias') {
            gameContainers.add(GameContainer(
              homeAlias: homeAlias ?? '',
              homeMarket: homeMarket ?? '',
              homeName: homeName ?? '',
              homeRecord: homeRecord ?? 0,
              awayAlias: awayAlias ?? '',
              awayMarket: awayMarket ?? '',
              awayName: awayName ?? '',
              awayRecord: awayRecord ?? 0,
            ));
          }
        }
      }
    }

    // Return a default container if the loop does not return a widget
    return Column(
      children: [...gameContainers],
    );
  }
}

class GameContainer extends StatelessWidget {
  final String homeAlias;
  final String homeMarket;
  final String homeName;
  final int homeRecord;
  final String awayAlias;
  final String awayMarket;
  final String awayName;
  final int awayRecord;

  GameContainer(
      {required this.homeAlias,
      required this.homeMarket,
      required this.homeName,
      required this.homeRecord,
      required this.awayAlias,
      required this.awayMarket,
      required this.awayName,
      required this.awayRecord});

  @override
  Widget build(BuildContext context) {
    if (homeAlias == null &&
        homeMarket == null &&
        homeName == null &&
        homeRecord == null &&
        awayAlias == null &&
        awayMarket == null &&
        awayName == null &&
        awayRecord == null) {
      return Container(
        margin: const EdgeInsets.all(10),
        width: 250,
        height: 100,
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.teal,
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xff343b45),
              ),
            )
          ],
        ),
      );
      // All variables are null or empty
    }

    return Container(
      margin: const EdgeInsets.all(10),
      width: 280,
      height: 100,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/team/$homeAlias.png',
                    width: 100,
                    height: 100,
                  ),
                  Text(homeMarket ?? '',
                      style: TextStyle(color: Colors.black)), // + homeName
                  Text(style: TextStyle(color: Colors.black), '$homeRecord'),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/team/$awayAlias.png',
                      width: 100,
                      height: 100,
                    ),
                    Text(awayMarket ?? '',
                        style: TextStyle(color: Colors.black)), // + homeName
                    Text(style: TextStyle(color: Colors.black), '$awayRecord'),
                  ],
                )),
          ),
        ],
      ),
    );
    throw UnimplementedError();
  }
}
