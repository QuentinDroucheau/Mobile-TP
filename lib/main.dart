import 'package:flutter/material.dart';
import 'package:mobile_tp/pages/home_page.dart';
import 'package:mobile_tp/services/sqflite_service.dart';
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MysteryNumberApp());
}

final database = SqfliteService().initializeDB();

class MysteryNumberApp extends StatelessWidget{

  MysteryNumberApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mystery Number',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}