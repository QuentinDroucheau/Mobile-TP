import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_tp/models/Aventure.dart';
import 'package:mobile_tp/models/Difficulte.dart';
import 'package:mobile_tp/models/Effectuer.dart';
import 'package:mobile_tp/models/Niveau.dart';
import 'package:mobile_tp/models/Partie.dart';
import 'package:mobile_tp/screens/MysteryNumberScreen2.dart';
import 'package:mobile_tp/screens/PageAventures.dart';
import 'package:mobile_tp/services/AventureDB.dart';
import 'package:mobile_tp/services/DifficulteDB.dart';
import 'package:mobile_tp/services/EffectuerDB.dart';
import 'package:mobile_tp/services/NiveauDB.dart';
import 'package:mobile_tp/services/PartieDB.dart';
import 'package:mobile_tp/widgets/carte_widget.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';

class NiveauScreen extends StatefulWidget{

  NiveauScreen({
    Key? key,
  }) : super(key: key);

  @override
  _NiveauScreen createState() => _NiveauScreen();
}

class _NiveauScreen extends State<NiveauScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aventure"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => PageAventures(
            //       database: widget.database,
            //     ),
            //   ),
            // );
          },
        ),
      ),
      body: CarteWidget(
        aventure: Aventure(id: 1, nomJoueur: "Joueur 1")
      )
    );
  }
}
