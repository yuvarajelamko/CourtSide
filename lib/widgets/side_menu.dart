import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SideMenu extends StatelessWidget{
  const SideMenu({super.key});


  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(accountName: Text('Username'), accountEmail: Text('example@gmail.com'),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.network('https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
              fit: BoxFit.cover,
              width: 90,
              height: 90,
              ),
            )
          ),
          decoration: const BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage('https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
          ),
          ),
            const SizedBox(height: 10,),
            ListTile(
              leading: const Icon(Icons.support_agent),
              title: const Text('Customer Support'),
              onTap: () async{
                const String url ='https://deriv.com/contact_us/';
                if (await launchUrl(Uri.parse(url))){
                  await launch(url);
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
                await launch(url);
              }else{
                throw 'Could not launch $url';
              }
            }
          ),
          const SizedBox(height: 40),
          Container(margin: const EdgeInsets.symmetric(horizontal: 60), child: ElevatedButton(onPressed: () {}, child: Text("Log Out")))
        ],
      )
    );
  }
}