import 'package:flutter/material.dart';
import 'package:mobile_tp/models/Aventure.dart';
import 'package:mobile_tp/models/Difficulte.dart';
import 'package:mobile_tp/models/Niveau.dart';
import 'package:mobile_tp/models/Partie.dart';
import 'package:mobile_tp/screens/MysteryNumberScreen.dart';
import 'package:mobile_tp/services/SqliteService.dart';

class MysteryNumberLoadScreen extends StatelessWidget{

  late Niveau niveau;
  late Aventure aventure;

  MysteryNumberLoadScreen({
    Key? key,
    required this.niveau,
    required this.aventure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final Future<Partie> partie = Future<Partie>.delayed(
      const Duration(seconds: 1),
      () => SqliteService().getPartie(aventure.id, niveau.id),
    );

    final Future<Difficulte> difficulte = Future<Difficulte>.delayed(
      const Duration(seconds: 1),
      () => SqliteService().getDifficulte(niveau.id),
    );

    return Center(
      child: FutureBuilder(
        future: Future.wait([partie, difficulte]),
        builder: (context, snapshot){
          if(snapshot.hasError){
            print("niveau : "+niveau.id.toString());
            print("aventure : "+aventure.id.toString());
            print("AAAAA");
            print(snapshot.error);
            return Text("${snapshot.error}");
          }else if(snapshot.hasData){
            final partie = snapshot.data![0];
            final difficulte = snapshot.data![1];

            if(partie is Partie && difficulte is Difficulte){
              return MysteryNumberScreen(partie: partie, difficulte: difficulte);
            }else{
              return const Text("Impossible de charger la partie");
            }
          }else{
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}