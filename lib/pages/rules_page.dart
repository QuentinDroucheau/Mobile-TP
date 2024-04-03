import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget{

  const RulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_accueil.jpeg'),
              fit: BoxFit.cover,
            ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Règles du jeu',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 100),
              const Text(
                'Bienvenue dans le jeu du nombre mystère !\n'
                'L\'objectif est de trouver un nombre généré aléatoirement\n'
                'Vous aurez des indications si votre nombre est trop grand ou trop petit\n'
                'Il y a plusieurs difficultés : \n'
                '- Facile : Vous avez 20 tentatives et le nombre se situe entre 1 et 50\n'
                '- Moyen : Vous avez 15 tentatives et le nombre se situe entre 1 et 150\n'
                '- Difficile : Vous avez 10 tentatives et le nombre se situe entre 1 et 300\n'
                'Créez vous une aventure, et parcourez les niveaux\n'
                'Bonne chance !\n',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text('Retour'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}