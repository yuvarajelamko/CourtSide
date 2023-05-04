import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/matchdetails.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _updateSelectedDate(
                      DateTime.now().subtract(Duration(days: 2))),
                  child: Text('Yesterday'),
                ),
                ElevatedButton(
                  onPressed: () => _updateSelectedDate(
                      DateTime.now().subtract(Duration(days: 1))),
                  child: const Text('Today'),
                ),
                ElevatedButton(
                  onPressed: () => _updateSelectedDate(DateTime.now()),
                  child: Text('Tomorrow'),
                ),
              ],
            ),
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
                final ongoingGames = games
                    ?.where((game) => game.status == 'inprogress')
                    .toList();
                final scheduledGames =
                    games?.where((game) => game.status == 'scheduled').toList();
                final closedGames =
                    games?.where((game) => game.status == 'closed').toList();

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Visibility(
                        visible: ongoingGames?.isEmpty == false,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyMatchDetails()),
                                  );
                                },
                                child: const ListTile(
                                  title: Text('Live Matches'),
                                ),
                              ),
                              SizedBox(
                                height: ongoingGames?.isEmpty == true ? 0 : 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: ongoingGames?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final game = ongoingGames![index];
                                    final homeTeamLastName =
                                        game.homeTeamName.split(' ').last;
                                    final awayTeamLastName =
                                        game.awayTeamName.split(' ').last;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          color: Colors.teal,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              game.title,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Image.asset(
                                                      'assets/team/${game.homeTeamAlias}.png',
                                                      width: 60,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      '$homeTeamLastName',
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 20),
                                                Text(
                                                  '${game.homePoints}',
                                                  style:
                                                      TextStyle(fontSize: 24),
                                                ),
                                                const Text(
                                                  '-',
                                                  style:
                                                      TextStyle(fontSize: 24),
                                                ),
                                                Text(
                                                  '${game.awayPoints}',
                                                  style:
                                                      TextStyle(fontSize: 24),
                                                ),
                                                const SizedBox(width: 20),
                                                Column(
                                                  children: [
                                                    Image.asset(
                                                      'assets/team/${game.awayTeamAlias}.png',
                                                      width: 60,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      '$awayTeamLastName',
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: scheduledGames?.isEmpty == false,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Column(
                            children: [
                              const ListTile(
                                title: Text('Upcoming Matches'),
                              ),
                              SizedBox(
                                height:
                                    scheduledGames?.isEmpty == true ? 0 : 350,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: scheduledGames?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final game = scheduledGames![index];
                                    final homeTeamLastName =
                                        game.homeTeamName.split(' ').last;
                                    final awayTeamLastName =
                                        game.awayTeamName.split(' ').last;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                title: const Center(
                                                  child: Text(
                                                    'H vs A',
                                                    style:
                                                        TextStyle(fontSize: 50),
                                                  ),
                                                ),
                                                contentPadding: EdgeInsets.zero,
                                                content: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9,
                                                  height: 200,
                                                  child: Stack(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: SizedBox(
                                                              height: 180,
                                                              child: Column(
                                                                children: const [
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(0),
                                                                    child: Center(
                                                                        child: Text(
                                                                            '"Odd H"')),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          20),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              height: 180,
                                                              child: Column(
                                                                children: const [
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(0),
                                                                    child: Center(
                                                                        child: Text(
                                                                            '"Odd A"')),
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          20),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Positioned(
                                                        bottom: 60,
                                                        left: 0,
                                                        right: 0,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            8.0),
                                                                child: Text(
                                                                  'Enter your bet amount:',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.8,
                                                                  height: 40,
                                                                  child:
                                                                      TextField(
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 20,
                                                        left: 0,
                                                        right: 0,
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: SizedBox(
                                                            width: 80,
                                                            height: 40,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {},
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                ),
                                                                backgroundColor:
                                                                    Colors
                                                                        .black,
                                                                foregroundColor:
                                                                    const Color(
                                                                        0xff43f5bf),
                                                              ),
                                                              child: const Text(
                                                                  'Bet'),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(15.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            color: Colors.teal,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                game.title,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Image.asset(
                                                        'assets/team/${game.homeTeamAlias}.png',
                                                        width: 60,
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        '$homeTeamLastName',
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Text(
                                                    '${game.homePoints}',
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  const Text(
                                                    '-',
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  Text(
                                                    '${game.awayPoints}',
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Column(
                                                    children: [
                                                      Image.asset(
                                                        'assets/team/${game.awayTeamAlias}.png',
                                                        width: 60,
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        '$awayTeamLastName',
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: closedGames?.isEmpty == false,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Column(
                            children: [
                              const ListTile(
                                title: Text('Past Matches'),
                              ),
                              SizedBox(
                                height: closedGames?.isEmpty == true ? 0 : 350,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: closedGames?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final game = closedGames![index];
                                    final homeTeamLastName =
                                        game.homeTeamName.split(' ').last;
                                    final awayTeamLastName =
                                        game.awayTeamName.split(' ').last;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(15.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          color: Colors.teal,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              game.title,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Image.asset(
                                                      'assets/team/${game.homeTeamAlias}.png',
                                                      width: 60,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      '$homeTeamLastName',
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 20),
                                                Text(
                                                  '${game.homePoints}',
                                                  style:
                                                      TextStyle(fontSize: 24),
                                                ),
                                                const Text(
                                                  '-',
                                                  style:
                                                      TextStyle(fontSize: 24),
                                                ),
                                                Text(
                                                  '${game.awayPoints}',
                                                  style:
                                                      TextStyle(fontSize: 24),
                                                ),
                                                const SizedBox(width: 20),
                                                Column(
                                                  children: [
                                                    Image.asset(
                                                      'assets/team/${game.awayTeamAlias}.png',
                                                      width: 60,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      '$awayTeamLastName',
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })
        ]),
      ),
    );
  }
}
