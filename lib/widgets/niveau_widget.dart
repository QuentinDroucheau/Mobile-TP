import 'package:flutter/material.dart';
import 'package:mobile_tp/models/aventure_model.dart';
import 'package:mobile_tp/models/niveau_model.dart';
import 'package:mobile_tp/pages/game_load_page.dart';

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
              builder: (context) => GameLoadPage(
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameLoadPage(
                niveau: niveau,
                aventure: aventure,
              ),
            ),
          );
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