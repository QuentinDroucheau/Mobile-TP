import 'package:flutter/material.dart';
import 'package:mobile_tp/models/Partie.dart';
import 'package:mobile_tp/screens/HistoriquePage.dart';
import 'package:mobile_tp/screens/PageAventures.dart';
import 'package:mobile_tp/widgets/carte_widget.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mobile_tp/widgets/partie_widget.dart';

class Home extends StatelessWidget {
  final Future<Database> database;

  Home({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Le nombre magique'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageAventures(database: database)),
                );
              },
              child: Text('Jouer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoriquePage()),
                );
              },
              child: Text('Historique'),
            ),
          ],
        ),
      ),
    );
  }
}