import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mobile_tp/screens/Home.dart';

class MysteryNumberApp extends StatelessWidget{
  final Future<Database> database;

  MysteryNumberApp({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mystery Number',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(database: database),
    );
  }
}