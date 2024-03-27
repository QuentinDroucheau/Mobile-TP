import 'package:flutter/material.dart';
import 'package:mobile_tp/screens/PageNiveaux.dart';

class PageAventures extends StatefulWidget {
  @override
  _PageAventuresState createState() => _PageAventuresState();
}

class _PageAventuresState extends State<PageAventures> {
  List<String> aventures = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Le nombre magique'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Choisissez votre aventure',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    ...aventures.map((nom) {
                      return Card(
                        child: ListTile(
                          title: Center(child: Text(nom)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PageNiveaux(totalNiveaux: 10, niveauxCompletes: 0)),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nom = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Créez une aventure'),
                content: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                  ),
                  onSubmitted: (value) {
                    Navigator.of(context).pop(value);
                  },
                ),
              );
            },
          );

          if (nom != null) {
            setState(() {
              aventures.add(nom);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}