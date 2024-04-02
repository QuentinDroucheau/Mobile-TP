import 'package:flutter/material.dart';
import 'package:mobile_tp/models/partie_model.dart';

class HistoriqueWidget extends StatelessWidget{

  final Partie partie;

  const HistoriqueWidget({
    super.key,
    required this.partie
  });

  @override
  Widget build(BuildContext context){
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width - 10,
      color: partie.gagne ? Colors.green : Colors.red,
      child: Column(
        children: [
          Text('Score: ${partie.score}'),
          Text('Nombre d\'essais: ${partie.nbEssaisJoueur}'),
          Text('Date de début: ${partie.dateDebut}'),
          Text('Niveau: ${partie.idNiveau}'),
        ],
      )
    );
  }
}