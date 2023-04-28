import 'package:courtside/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'store/apiStore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textController = TextEditingController();

  String _data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
      ),
      drawer: const SideMenu(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(margin: const EdgeInsets.all(10),
                child: TextField(
                  controller: _textController,
                  onSubmitted: (String dataType) {
                    getData(dataType).then((game) {
                      print(game.title);
                      print(game.status);
                      setState(() {
                        _data = "Game title: ${game.title}. Game status: ${game.status}";
                      });
                    });
                  },
                ),
              ),
            ),
            // Container(color: Colors.red, height: 200, width: 200,),
            Text(_data),
          ],
        ),
      ),
    );
  }
}
