import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pages/landingpage.dart';

class SideMenu extends StatelessWidget {
  final String username;
  final String email;

  const SideMenu({Key? key, required this.username, required this.email})
      : super(key: key);

  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => LandingPage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign out. Please try again later.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(username),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    'assets/sidemenu/profilepic.png',
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/sidemenu/sidemenu_bg.jpg"),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            ListTile(
                leading: const Icon(Icons.support_agent),
                title: const Text('Customer Support'),
                onTap: () async{
                  const String url ='https://deriv.com/contact_us/';
                  if (await launchUrl(Uri.parse(url))){
                    launchUrl;
                  }else{
                    throw 'Could not launch $url';
                  }
                }
            ),
            const SizedBox(height: 10,),
            ListTile(
                leading: const Icon(Icons.rule_sharp),
                title: const Text('Terms and Conditions'),
                onTap: () async{
                  const String url = 'https://deriv.com/terms-and-conditions/';
                  if(await launchUrl(Uri.parse(url))){
                    launchUrl;
                  }else{
                    throw 'Could not launch $url';
                  }
                }
            ),
            const SizedBox(height: 40),
            Container(margin: const EdgeInsets.symmetric(horizontal: 60), child: ElevatedButton(onPressed: () => _signOut(context), child: Text("Log Out")))
          ],
        )
    );
  }
}
