import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'info_card.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 280,
          height: double.infinity,
          color: Colors.black,
          child: SafeArea(
            child: Column(
              children:  [
                const InfoCard(name: 'Bentley', fan: 'Warriors Fan'),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(margin: const EdgeInsets.all(10),
                      child: Expanded(
                        child: ElevatedButton(onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                            ),
                            child: const Text('Customer Support')),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            const String url = 'https://deriv.com/terms-and-conditions/#clients';
                            launchUrl(url);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: const Text('Terms and Conditions'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: const Text("Log Out"))

              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Method to launch the URL
Future<void> launchUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}