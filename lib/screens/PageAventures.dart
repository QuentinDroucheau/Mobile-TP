import 'package:flutter/material.dart';
import 'package:mobile_tp/models/Aventure.dart';
import 'package:mobile_tp/models/Niveau.dart';
import 'package:mobile_tp/screens/PageNiveaux.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mobile_tp/services/AventureDB.dart';

class PageAventures extends StatefulWidget {
  final Future<Database> database;

  PageAventures({Key? key, required this.database}) : super(key: key);

  @override
  _PageAventuresState createState() => _PageAventuresState();
}

class _PageAventuresState extends State<PageAventures> {
  List<Aventure> aventures = [];
  late AventureDB aventureDB;

  @override
  void initState() {
    super.initState();
    aventureDB = AventureDB(database: widget.database);
    loadAventures();
  }

  Future<void> loadAventures() async {
    final aventureList = await aventureDB.getAll();
    setState(() {
      aventures = aventureList;
    });
  }

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
              ...aventures.map((aventure) {
                return FutureBuilder<List<Niveau>>(
                  future: aventureDB.getLevelsWon(aventure.id ?? 0),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erreur : ${snapshot.error}');
                    } else {
                      List<Niveau> levelsWon = snapshot.data ?? [];
                      int nextLevel =
                          levelsWon.length < 10 ? levelsWon.length + 1 : 11;
                      String status = nextLevel <= 10 ? 'En cours' : 'Terminée';
                      String message = status == 'En cours'
                          ? 'Prochain niveau : $nextLevel'
                          : 'Terminée';

                      return Card(
                        color: status == 'Terminée'
                            ? Colors.green[100]
                            : Colors.white,
                        child: ListTile(
                          title: Center(child: Text(aventure.nomJoueur)),
                          subtitle: Text(message),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PageNiveaux(
                                    totalNiveaux: 10,
                                    idAventure: aventure.id ?? 0,
                                    database: widget.database),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
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
            final id = await aventureDB.add(nom);
            setState(() {
              aventures.add(Aventure(id: id, nomJoueur: nom));
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
