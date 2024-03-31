import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_tp/models/Effectuer.dart';
import 'package:mobile_tp/models/Partie.dart';
import 'package:mobile_tp/screens/PageNiveaux.dart';
import 'package:mobile_tp/services/EffectuerDB.dart';
import 'package:mobile_tp/services/PartieDB.dart';
import 'package:mobile_tp/services/SqliteService.dart';
import 'package:sqflite/sqflite.dart';

class MysteryNumberScreen extends StatefulWidget {
  final Future<Database> database;
  final int idPartie;
  final int idNiveau;
  final int idDifficulte;
  final int idAventure;
  final EffectuerDB effectuerDB;

  final VoidCallback onPartieFinished;

  MysteryNumberScreen({
    Key? key,
    required this.database,
    required this.idPartie,
    required this.idNiveau,
    required this.idDifficulte,
    required this.idAventure,
    required this.effectuerDB,
    required this.onPartieFinished,
  }) : super(key: key);

  @override
  _MysteryNumberScreenState createState() => _MysteryNumberScreenState();
}

class _MysteryNumberScreenState extends State<MysteryNumberScreen> {
  int _mysteryNumber = 0;
  int _number = 0;
  String _message = "";
  late PartieDB partieDB;

  @override
  void initState() {
    super.initState();
    partieDB = PartieDB(database: widget.database);
    _reset();
  }

  void _reset() async {
    Partie partie = await partieDB.getById(widget.idPartie);
    _mysteryNumber = partie.nbMystere;
    _number = 0;
    _message = 'Trouve le nombre';
  }

  void _check() async {
    if (_number == 0) {
      _message = 'Entrez un nombre :';
    } else if (_number < _mysteryNumber) {
      _message = 'Trop petit !';
    } else if (_number > _mysteryNumber) {
      _message = 'Trop grand !';
    } else {
      _message = 'Vous avez trouvé le nombre !';
      Effectuer effectuer = Effectuer(
        idAventure: widget.idAventure,
        idNiveau: widget.idNiveau,
        idPartie: widget.idPartie,
        complete: true,
      );
      print('Adding Effectuer with values: ${effectuer.toMap()}');
      await widget.effectuerDB.add(effectuer);
      Partie oldPartie = await partieDB.getById(widget.idPartie);

      oldPartie.gagne = true;
      print('Updating Partie with values: ${oldPartie.toMap()}');
      await partieDB.update(oldPartie);

      widget.onPartieFinished();
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
            if (_message == 'Vous avez trouvé le nombre !')
              Column(
                children: [
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageNiveaux(
                          totalNiveaux: 10,
                          idAventure: widget.idAventure,
                          database: widget.database,
                        ),
                      ),
                    ),
                    child: Text('Retour'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
