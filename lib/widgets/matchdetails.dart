import 'package:flutter/material.dart';

class MyMatchDetails extends StatelessWidget {
  const MyMatchDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Match Details'),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  '"Home - Away"',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xff43F5BF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '"Ongoing matches"',
                  style: TextStyle(color: Color(0xFF39444E)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 350,
                decoration: BoxDecoration(
                  color: const Color(0xff43F5BF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF39444E),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Container 1',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.42,
                          height: 260,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFF39444E),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Text(
                            'Container 1',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.42,
                          height: 260,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFF39444E),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Text(
                            'Container 2',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xff43F5BF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Bets Page 3',
                  style: TextStyle(color: Color(0xFF39444E)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
