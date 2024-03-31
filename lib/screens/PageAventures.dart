import 'package:flutter/material.dart';
import 'package:mobile_tp/models/Aventure.dart';
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
                return Card(
                  child: ListTile(
                    title: Center(child: Text(aventure.nomJoueur)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageNiveaux(
                                totalNiveaux: 10, idAventure: aventure.id ?? 0, database: widget.database)),
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
