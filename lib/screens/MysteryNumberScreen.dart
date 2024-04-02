import 'package:flutter/material.dart';
import 'package:mobile_tp/models/Aventure.dart';
import 'package:mobile_tp/models/Difficulte.dart';
import 'package:mobile_tp/models/Niveau.dart';
import 'package:mobile_tp/models/Partie.dart';
import 'package:mobile_tp/screens/NiveauScreen.dart';
import 'package:mobile_tp/services/SqliteService.dart';

class MysteryNumberScreen extends StatefulWidget{

  late Partie partie;
  late Difficulte difficulte;
  late Aventure aventure;

  MysteryNumberScreen({
    Key? key,
    required this.partie,
    required this.difficulte,
    required this.aventure,
  }) : super(key: key);

  @override
  _MysteryNumberScreen createState() => _MysteryNumberScreen();
}

class _MysteryNumberScreen extends State<MysteryNumberScreen>{
  
  late int _nombre = 0;
  late int _nombreMystere = 0;
  late String _message = "Trouve le nombre "+_nombreMystere.toString();
  late bool _gameOver = false;

  @override
  void initState() {
    _nombreMystere = widget.partie.nbMystere;
    super.initState();
  }

  void _check(){
    setState((){
      if(_nombre == _nombreMystere){
        _message = "Bravo !";
        widget.partie.gagne = true;
        widget.partie.dateFin = DateTime.now();

        SqliteService().addPartie(widget.partie);

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
    });
  }

  @override
  Widget build(BuildContext context){
    if(widget.partie.gagne){
      return Scaffold(
        appBar: AppBar(
          title: Text('Mystery Number'),
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
                      builder: (context) => NiveauScreen(),
                    ),
                  );
                },
                child: Text('Quitter'),
              ),
            ],
          ),
        )
      );
    }else if(!_gameOver){
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
              ElevatedButton(
                child: Text('Quitter'),
                onPressed: (){
                  SqliteService().addPartie(widget.partie);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                child: Text('Abandonner'),
                onPressed: (){
                  widget.partie.gagne = false;
                  widget.partie.dateFin = DateTime.now();
                  SqliteService().addPartie(widget.partie);
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
          title: Text('Mystery Number'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_message, style: TextStyle(fontSize: 24),),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('Quitter'),
              ),
            ],
          ),
        )
      );
    }
  }
}