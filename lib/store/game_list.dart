import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'api_store.dart';

class GamesList extends StatefulWidget {
  @override
  _GamesListState createState() => _GamesListState();
}

class _GamesListState extends State<GamesList> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().subtract(Duration(days: 1));
  }

  void _updateSelectedDate(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _updateSelectedDate(DateTime.now().subtract(Duration(days: 2))),
                child: Text('Yesterday'),
              ),
              ElevatedButton(
                onPressed: () => _updateSelectedDate(DateTime.now().subtract(Duration(days: 1))),
                child: Text('Today'),
              ),
              ElevatedButton(
                onPressed: () => _updateSelectedDate(DateTime.now()),
                child: Text('Tomorrow'),
              ),
            ],
          ),
          FutureBuilder(
              future: ApiStore.getGames(_selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return Container();
                }
                final games = snapshot.data;
                final ongoingGames = games?.where((game) => game.status == 'inprogress').toList();
                final scheduledGames = games?.where((game) => game.status == 'scheduled').toList();
                final closedGames = games?.where((game) => game.status == 'closed').toList();

                return Column(
    children: [
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Live Matches'),
                    ),
                    SizedBox(
                      height: ongoingGames?.isEmpty == true ? 0 : 150,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: ongoingGames?.length,
                        itemBuilder: (BuildContext context, int index) {
                          final game = ongoingGames![index];
                          final homeTeamLastName = game.homeTeamName
                              .split(' ')
                              .last;
                          final awayTeamLastName = game.awayTeamName
                              .split(' ')
                              .last;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(game.title),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Image.asset(
                                        'assets/team/${game.homeTeamAlias}.png',
                                        width: 20),
                                    SizedBox(width: 5),
                                    Text('$homeTeamLastName',
                                        style: TextStyle(fontSize: 16)),
                                    Text('${game.homePoints}',
                                        style: TextStyle(fontSize: 24)),
                                    Text('-', style: TextStyle(fontSize: 24)),
                                    Text('${game.awayPoints}',
                                        style: TextStyle(fontSize: 24)),
                                    Text('$awayTeamLastName',
                                        style: TextStyle(fontSize: 16)),
                                    SizedBox(width: 5),
                                    Image.asset(
                                        'assets/team/${game.awayTeamAlias}.png',
                                        width: 20),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),


              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Upcoming Matches'),
                    ),
                    SizedBox(
                      height: scheduledGames?.isEmpty == true ? 0 : 150,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: scheduledGames?.length,
                        itemBuilder: (BuildContext context, int index) {
                          final game = scheduledGames![index];
                          final homeTeamLastName = game.homeTeamName
                              .split(' ')
                              .last;
                          final awayTeamLastName = game.awayTeamName
                              .split(' ')
                              .last;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(game.title),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Image.asset(
                                        'assets/team/${game.homeTeamAlias}.png',
                                        width: 20),
                                    SizedBox(width: 5),
                                    Text('$homeTeamLastName',
                                        style: TextStyle(fontSize: 16)),
                                    SizedBox(width: 10),
                                    Text(
                                      DateFormat.jm().format(game.scheduled),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: 10),
                                    Text('$awayTeamLastName',
                                        style: TextStyle(fontSize: 16)),
                                    SizedBox(width: 5),
                                    Image.asset(
                                        'assets/team/${game.awayTeamAlias}.png',
                                        width: 20),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Past Matches'),
                    ),
                    SizedBox(
                      height: closedGames?.isEmpty == true ? 0 : 150,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: closedGames?.length,
                        itemBuilder: (BuildContext context, int index) {
                          final game = closedGames![index];
                          final homeTeamLastName = game.homeTeamName
                              .split(' ')
                              .last;
                          final awayTeamLastName = game.awayTeamName
                              .split(' ')
                              .last;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(game.title),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Image.asset(
                                        'assets/team/${game.homeTeamAlias}.png',
                                        width: 20),
                                    SizedBox(width: 5),
                                    Text('$homeTeamLastName',
                                        style: TextStyle(fontSize: 16)),
                                    Text('${game.homePoints}',
                                        style: TextStyle(fontSize: 24)),
                                    Text('-', style: TextStyle(fontSize: 24)),
                                    Text('${game.awayPoints}',
                                        style: TextStyle(fontSize: 24)),
                                    Text('$awayTeamLastName',
                                        style: TextStyle(fontSize: 16)),
                                    SizedBox(width: 5),
                                    Image.asset(
                                        'assets/team/${game.awayTeamAlias}.png',
                                        width: 20),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
    )
  ]);
  }
}
