import 'package:flutter/material.dart';
import 'package:mobile_tp/screens/MysteryNumberScreen.dart';

class MysteryNumberApp extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mystery Number',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MysteryNumberScreen(),
    );
  }
}