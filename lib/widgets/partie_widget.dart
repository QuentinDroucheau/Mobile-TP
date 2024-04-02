import 'package:flutter/material.dart';
import 'package:mobile_tp/models/historique_model.dart';

class HistoriqueWidget extends StatelessWidget{

  final Historique historique;

  const HistoriqueWidget({
    super.key,
    required this.historique
  });

  @override
  Widget build(BuildContext context){
    Color color = Colors.green;
    if(historique.partie.dateFin == null){
      color = Colors.orange;
    }else if(historique.partie.gagne == false){
      color = Colors.red;
    }
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width - 10,
      color: color,
      child: Column(
        children: [
          Text('Aventure: ${historique.aventure.nomJoueur}'),
          Text('Nombre d\'essais: ${historique.partie.nbEssaisJoueur}'),
          Text('Niveau: ${historique.partie.idNiveau}'),
        ],
      )
    );
  }
}