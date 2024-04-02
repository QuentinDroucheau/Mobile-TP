import 'package:flutter/material.dart';
import 'package:mobile_tp/models/aventure_model.dart';
import 'package:mobile_tp/models/difficulte_model.dart';
import 'package:mobile_tp/models/niveau_model.dart';
import 'package:mobile_tp/models/partie_model.dart';
import 'package:mobile_tp/pages/game_page.dart';
import 'package:mobile_tp/services/sqflite_service.dart';

class GameLoadPage extends StatelessWidget{

  final Niveau niveau;
  final Aventure aventure;

  const GameLoadPage({
    Key? key,
    required this.niveau,
    required this.aventure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final Future<Partie> partie = Future<Partie>.delayed(
      const Duration(seconds: 2),
      () => SqfliteService().getPartie(aventure.id, niveau.id),
    );

    final Future<Difficulte> difficulte = Future<Difficulte>.delayed(
      const Duration(seconds: 1),
      () => SqfliteService().getDifficulte(niveau.id),
    );

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Center(
        child: FutureBuilder(
          future: Future.wait([partie, difficulte]),
          builder: (context, snapshot){
            
            if(snapshot.hasError){
              return Text("${snapshot.error}");

            }else if(snapshot.hasData){
              final partie = snapshot.data![0];
              final difficulte = snapshot.data![1];

              if(partie is Partie && difficulte is Difficulte){
                return GamePage(partie: partie, difficulte: difficulte, aventure: aventure);
              }else{
                return const Text("Impossible de charger la partie");
              }
            }else{
              return Container(
                height: 60,
                width: 60,
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}