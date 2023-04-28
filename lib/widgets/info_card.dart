import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget{
  const InfoCard({
    Key ? key,
    required this.name,
    required this.fan,
  }): super(key:key);

  final String name, fan;

  @override
  Widget build(BuildContext context){
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(CupertinoIcons.person,color: Colors.white,),
      ),
      title: Text(style: const TextStyle(color: Colors.white),name),
      subtitle: Text(style: const TextStyle(color: Colors.white),fan),
    );
  }
}