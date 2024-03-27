import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_tp/models/Partie.dart';

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
      color: partie.gagnee ? Colors.green : Colors.red,
      child: Column(
        children: [
          Text('Score: ${partie.score}'),
          Text('Nombre d\'essais: ${partie.nbEssais}'),
          Text('Date de début: ${partie.dateDebut}'),
          Text('Niveau: ${partie.idNiveau}'),
        ],
      )
    );
  }
}