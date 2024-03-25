import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Le nombre magique'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // page d'aventures
              },
              child: Text('Jouer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // page d'historique
              },
              child: Text('Historique'),
            ),
          ],
        ),
      ),
    );
  }
}