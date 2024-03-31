import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_tp/models/Difficulte.dart';
import 'package:mobile_tp/models/Effectuer.dart';
import 'package:mobile_tp/models/Niveau.dart';
import 'package:mobile_tp/models/Partie.dart';
import 'package:mobile_tp/screens/PageNiveaux.dart';
import 'package:mobile_tp/services/EffectuerDB.dart';
import 'package:mobile_tp/services/NiveauDB.dart';
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
  String _message = "Trouve le nombre";
  late PartieDB partieDB;
  late NiveauDB niveauDB;
  bool _gameOver = false;
  final _controller = TextEditingController();
  Difficulte? _difficulte;

  @override
  void initState() {
    super.initState();
    partieDB = PartieDB(database: widget.database);
    niveauDB = NiveauDB(database: widget.database);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reset();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _reset() async {
    _controller.clear();
    Partie partie = await partieDB.getById(widget.idPartie);
    Niveau niveau = await niveauDB.getById(partie.idNiveau);
    Difficulte difficulte =
        await niveauDB.getDifficulteById(niveau.idDifficulte);
    setState(() {
      _difficulte = difficulte;
      _mysteryNumber = partie.nbMystere;
      _number = 0;
      _message = 'Trouve le nombre';
    });
  }

  void _check() async {
    if (_number == 0) {
      _message = 'Entrez un nombre :';
    } else if (_number < _mysteryNumber) {
      _message = 'Trop petit !';
      _difficulte!.nbTentatives--;
    } else if (_number > _mysteryNumber) {
      _message = 'Trop grand !';
      _difficulte!.nbTentatives--;
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

    if (_difficulte!.nbTentatives == 0 && _number != _mysteryNumber) {
      _message = 'Vous avez perdu !';
      setState(() {
        _gameOver = true;
      });
    }

    setState(() {
      _number = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_difficulte == null) {
      return CircularProgressIndicator();
    }
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
            Text('Difficulté: ${_difficulte?.nomDifficulte}'),
            Text('Tentatives restantes: ${_difficulte!.nbTentatives}'),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
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
            if (_gameOver)
              ElevatedButton(
                onPressed: () {
                  _reset();
                  setState(() {
                    _gameOver = false;
                  });
                },
                child: Text('Recommencer'),
              ),
          ],
        ),
      ),
    );
  }
}
