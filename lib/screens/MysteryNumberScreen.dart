import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_tp/services/SqliteService.dart';

class MysteryNumberScreen extends StatefulWidget{

  @override
  _MysteryNumberScreenState createState() => _MysteryNumberScreenState();
}

class _MysteryNumberScreenState extends State<MysteryNumberScreen>{
  int _mysteryNumber = 0;
  int _number = 0;
  String _message = "";

  @override
  void initState(){
    super.initState();
    _reset();
    SqliteService sqliteService = SqliteService();
    sqliteService.initializeDB();
  }

  void _reset() {
    Random random = Random();
    _mysteryNumber = random.nextInt(100) + 1;
    _number = 0;
    _message = 'Trouve le nombre';
  }

  void _check() {
    if (_number == 0) {
      _message = 'Entrez un nombre :';
    } else if (_number < _mysteryNumber) {
      _message = 'Trop petit !';
    } else if (_number > _mysteryNumber) {
      _message = 'Trop grand !';
    } else {
      _message = 'Vous avez trouvé le nombre !';
    }
    setState(() {
      _number = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mystery Number'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _message,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _number = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _check,
              child: Text('Valider'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _reset,
              child: Text('Recommencer'),
            ),
          ],
        ),
      ),
    );
  }
}