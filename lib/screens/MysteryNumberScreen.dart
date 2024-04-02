import 'package:flutter/material.dart';
import 'package:mobile_tp/models/Aventure.dart';
import 'package:mobile_tp/models/Difficulte.dart';
import 'package:mobile_tp/models/Niveau.dart';
import 'package:mobile_tp/models/Partie.dart';
import 'package:mobile_tp/services/SqliteService.dart';

class MysteryNumberScreen extends StatefulWidget{

  late Partie partie;
  late Difficulte difficulte;

  MysteryNumberScreen({
    Key? key,
    required this.partie,
    required this.difficulte,
  }) : super(key: key);

  @override
  _MysteryNumberScreen createState() => _MysteryNumberScreen();
}

class _MysteryNumberScreen extends State<MysteryNumberScreen>{
  
  late int _nombre = 0;
  late int _nombreMystere = 0;
  late String _message = "Trouve le nombre";
  late bool _gameOver = false;

  void _check()async{
    if(_nombre == _nombreMystere){
      _message = "Bravo !";
      _gameOver = false;
    }else if(_nombre < _nombreMystere){
      _message = "Trop petit";
    }else{
      _message = "Trop grand";
    }

    widget.partie.nbEssaisJoueur++;

    if(widget.partie.nbEssaisJoueur >= widget.difficulte.nbTentatives){
      _message = "Perdu !";
      _gameOver = true;
    }
  }

  @override
  Widget build(BuildContext context){
    if(!_gameOver){
      return Scaffold(
        appBar: AppBar(
          title: Text('Mystery Number'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_message, style: TextStyle(fontSize: 24),),
              const SizedBox(height: 20,),
              Text("Difficulté: "+ widget.difficulte.nomDifficulte),
              Text("Tentatives restantes: "+ (widget.difficulte.nbTentatives - widget.partie.nbEssaisJoueur).toString()),
              SizedBox(height: 20,),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value){
                  setState(() {
                    _nombre = int.tryParse(value) ?? 0;
                  });
                },
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: _check,
                child: const Text('Valider'),
              ),
              const SizedBox(height: 20,),
              const ElevatedButton(
                onPressed: null,
                child: Text('Quitter'),
              ),
            ],
          ),
        )
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: Text('Mystery Number'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_message, style: TextStyle(fontSize: 24),),
              const SizedBox(height: 20,),
              const ElevatedButton(
                onPressed: null,
                child: Text('Quitter'),
              ),
            ],
          ),
        )
      );
    }
  }
}