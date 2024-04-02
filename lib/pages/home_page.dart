import 'package:flutter/material.dart';
import 'package:mobile_tp/pages/historique_page.dart';
import 'package:mobile_tp/pages/aventures_page.dart';

class HomePage extends StatelessWidget{

  const HomePage({Key? key}) : super(key: key);

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
                'Mystery Number',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AventurePage()),
                  );
                },
                child: const Text('Jouer'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoriquePage()),
                  );
                },
                child: const Text('Historique'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}