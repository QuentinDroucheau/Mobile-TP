import 'package:flutter/material.dart';
import 'package:mobile_tp/models/Aventure.dart';
import 'package:mobile_tp/models/Niveau.dart';
import 'package:mobile_tp/screens/MysteryNumberLoadScreen.dart';
import 'package:mobile_tp/services/SqliteService.dart';

class NiveauWidget extends StatelessWidget{

  final Aventure aventure;
  final Niveau niveau;
  final bool complete;
  final bool niveauPrecedentComplete;

  const NiveauWidget({
    Key? key,
    required this.aventure,
    required this.niveau,
    required this.complete,
    required this.niveauPrecedentComplete
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    if(complete){
      return GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MysteryNumberLoadScreen(
                niveau: niveau,
                aventure: aventure,
              ),
            ),
          );
        },
        child: CircleAvatar(
          backgroundColor: Colors.green,
          child: Text(niveau.palier.toString()),
        ),
      );
    }else if(niveauPrecedentComplete){
      return GestureDetector(
        onTap: (){
          print("a faire");
        },
        child: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(niveau.palier.toString()),
        ),
      );
    }
    return CircleAvatar(
        backgroundColor: Colors.grey,
        child: Text(niveau.palier.toString()),
    );
  }
}