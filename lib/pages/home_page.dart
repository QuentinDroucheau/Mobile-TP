import 'package:flutter/material.dart';
import 'package:mobile_tp/pages/historique_page.dart';
import 'package:mobile_tp/pages/aventures_page.dart';

class HomePage extends StatelessWidget{

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Le nombre magique'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoriquePage()),
                );
              },
              child: const Text('Historique'),
            ),
          ],
        ),
      ),
    );
  }
}