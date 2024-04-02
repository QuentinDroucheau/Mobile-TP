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

class PageNiveaux extends StatefulWidget {
  final int totalNiveaux;
  final int idAventure;
  final Future<Database> database;

  PageNiveaux({
    Key? key,
    required this.totalNiveaux,
    required this.idAventure,
    required this.database,
  }) : super(key: key);

  @override
  _PageNiveauxState createState() => _PageNiveauxState();
}

class _PageNiveauxState extends State<PageNiveaux> {
  late List<Niveau> doneLevels = [];
  late AventureDB aventureDB;
  late PartieDB partieDB;
  late EffectuerDB effectuerDB;
  late NiveauDB niveauDB;
  late DifficulteDB difficulteDB;
  final _levelsController = StreamController<List<Niveau>>();

  @override
  void initState() {
    super.initState();
    aventureDB = AventureDB(database: widget.database);
    partieDB = PartieDB(database: widget.database);
    effectuerDB = EffectuerDB(database: widget.database);
    niveauDB = NiveauDB(database: widget.database);
    difficulteDB = DifficulteDB(database: widget.database);
    loadLevels();
  }

  Future<void> loadLevels() async {
    final partiesWon =
        await partieDB.getPartiesWonForAventure(widget.idAventure);
    final levelsWon = await Future.wait(
        partiesWon.map((partie) => niveauDB.getById(partie.idNiveau)));
    _levelsController.add(levelsWon);
  }

  @override
  void dispose() {
    _levelsController.close();
    super.dispose();
  }

  void startNewGame(int niveau) async {
    int idDifficulte;
    if (niveau <= 3) {
      idDifficulte = 1;
    } else if (niveau <= 7) {
      idDifficulte = 2;
    } else {
      idDifficulte = 3;
    }

    Difficulte difficulte = await difficulteDB.getById(idDifficulte);

    int mysteryNumber = Random().nextInt(difficulte.valeurMax) + 1;
    Partie nouvellePartie = Partie(
      score: 0,
      nbMystere: mysteryNumber,
      nbEssaisJoueur: difficulte.nbTentatives,
      gagne: false,
      dateDebut: DateTime.now(),
      dateFin: DateTime.now(),
      idAventure: widget.idAventure,
      idNiveau: niveau,
    );
    int idNouvellePartie = await partieDB.add(nouvellePartie);
    print(nouvellePartie.toString());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MysteryNumberScreen(
          database: widget.database,
          idPartie: idNouvellePartie,
          idNiveau: niveau,
          idDifficulte: idDifficulte,
          idAventure: widget.idAventure,
          effectuerDB: effectuerDB,
          onPartieFinished: () async {
            await loadLevels();
            if (nouvellePartie.gagne) {
              await effectuerDB.add(Effectuer(
                idAventure: widget.idAventure,
                idPartie: idNouvellePartie,
                idNiveau: niveau,
                complete: true,
              ));
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CarteWidget(
      aventure: Aventure(id: 1, nomJoueur: "Joueur 1")
    );
  }
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Aventure'),
    //     leading: IconButton(
    //       icon: const Icon(Icons.arrow_back),
    //       onPressed: () {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => PageAventures(
    //               database: widget.database,
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ),
      //body: const Center(
        //child: CarteWidget(
        //  idAventure: 1,
        //),
        // child: StreamBuilder<List<Niveau>>(
        //   stream: _levelsController.stream,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       doneLevels = snapshot.data!;
        //       return SingleChildScrollView(
        //         reverse: true,
        //         child: Column(
        //           children: List.generate(widget.totalNiveaux * 2 - 1, (index) {
        //             if (index % 2 == 0) {
        //               int niveau = widget.totalNiveaux - index ~/ 2;
        //               bool niveauGagne = doneLevels
        //                   .any((niveauGagne) => niveauGagne.palier == niveau);
        //               bool niveauPrecedentGagne = niveau == 1 ||
        //                   doneLevels.any((niveauGagne) =>
        //                       niveauGagne.palier == niveau - 1);
        //               return GestureDetector(
        //                 onTap: niveauGagne
        //                     ? null
        //                     : (niveauPrecedentGagne
        //                         ? () => startNewGame(niveau)
        //                         : null),
        //                 child: CircleAvatar(
        //                   backgroundColor:
        //                       niveauGagne ? Colors.green : Colors.grey,
        //                   child: Text(niveau.toString()),
        //                 ),
        //               );
        //             } else {
        //               return Transform.translate(
        //                 offset: Offset(30, 20),
        //                 child: Transform.rotate(
        //                   angle: 45,
        //                   child: Container(
        //                     height: 30,
        //                     width: 5,
        //                     color: Colors.black,
        //                   ),
        //                 )
        //               );
        //               // return Container(
        //               //   height: 30,
        //               //   width: 30,
        //               //   // child: const Icon(Icons.arrow_upward),
        //               //   color: Colors.red,
                        
        //               // );
        //               // child: Transform.rotate(angle: 50, child: Icon(Icons.arrow_upward)),
        //             }
        //           }),
        //         ),
        //       );
        //     } else {
        //       return CircularProgressIndicator();
        //     }
        //   },
        // ),
}
