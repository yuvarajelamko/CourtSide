import 'package:flutter/material.dart';

class MyMatchDetails extends StatelessWidget {
  const MyMatchDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            Container(
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
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xff43f5bf),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '"Ongoing matches"',
                  style: TextStyle(color: Color(0xFF39444E)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xff43f5bf),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF39444E),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Text(
                        '"Game Slots"',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            height: 400,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF39444E),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Text(
                              '"Home stats"',
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
                              '"Away stats"',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        title: const Center(
                          child: Text(
                            'H vs A',
                            style: TextStyle(fontSize: 50),
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
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
                                            padding: EdgeInsets.all(0),
                                            child:
                                                Center(child: Text('"Odd H"')),
                                          ),
                                          SizedBox(height: 20),
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
                                            padding: EdgeInsets.all(0),
                                            child:
                                                Center(child: Text('"Odd A"')),
                                          ),
                                          SizedBox(height: 20),
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
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Enter your bet amount:',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: 40,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
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
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 80,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        backgroundColor: Colors.black,
                                        foregroundColor:
                                            const Color(0xff43f5bf),
                                      ),
                                      child: const Text('Bet'),
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
                child: Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xff43f5bf),
                        width: 3,
                      ),
                    ),
                    child: const Text(
                      'Who will win?',
                      style: TextStyle(
                        color: Color(0xff43f5bf),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
