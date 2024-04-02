import 'package:flutter/material.dart';
import 'package:mobile_tp/models/aventure_model.dart';
import 'package:mobile_tp/models/difficulte_model.dart';
import 'package:mobile_tp/models/partie_model.dart';
import 'package:mobile_tp/pages/carte_page.dart';
import 'package:mobile_tp/services/sqflite_service.dart';

class GamePage extends StatefulWidget{

  final Partie partie;
  final Difficulte difficulte;
  final Aventure aventure;

  const GamePage({
    Key? key,
    required this.partie,
    required this.difficulte,
    required this.aventure,
  }) : super(key: key);

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage>{
  
  late int _nombre = 0;
  late int _nombreMystere = 0;
  late String _message = "";
  late bool _gameOver = false;

  @override
  void initState() {
    _nombreMystere = widget.partie.nbMystere;
    _message = "Trouve le nombre ($_nombreMystere)";
    super.initState();
  }

  void _check(){
    setState((){
      if(_nombre == _nombreMystere){
        _message = "Bravo !";
        widget.partie.gagne = true;
        widget.partie.dateFin = DateTime.now();

        SqfliteService().addPartie(widget.partie);

      }else if(_nombre < _nombreMystere){
        _message = "Trop petit !";
      }else{
        _message = "Trop grand !";
      }

      widget.partie.nbEssaisJoueur++;

      if(widget.partie.nbEssaisJoueur >= widget.difficulte.nbTentatives){
        _message = "Perdu !";
        _gameOver = true;
      }
    });
  }

  @override
  Widget build(BuildContext context){
    if(widget.partie.gagne){
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mystery Number'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Vous avez gagné !", style: TextStyle(fontSize: 24),),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartePage(
                        aventure: widget.aventure,
                      ),
                    ),
                  );
                },
                child: const Text('Quitter'),
              ),
            ],
          ),
        )
      );
    }else if(!_gameOver){
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mystery Number'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_message, 
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20,),
              Text("Difficulté: ${widget.difficulte.nomDifficulte}"),
              Text("Tentatives restantes: ${widget.difficulte.nbTentatives - widget.partie.nbEssaisJoueur}"),
              const SizedBox(height: 20,),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value){
                  setState((){
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
              ElevatedButton(
                child: const Text('Quitter'),
                onPressed: (){
                  SqfliteService().addPartie(widget.partie);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                child: const Text('Abandonner'),
                onPressed: (){
                  widget.partie.gagne = false;
                  widget.partie.dateFin = DateTime.now();
                  SqfliteService().addPartie(widget.partie);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        )
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mystery Number'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_message, 
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text('Quitter'),
              ),
            ],
          ),
        )
      );
    }
  }
}