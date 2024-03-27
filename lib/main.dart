import 'package:flutter/widgets.dart';
import 'package:mobile_tp/models/Niveau.dart';
import 'package:mobile_tp/services/NiveauDB.dart';
import 'package:mobile_tp/screens/MysteryNumberApp.dart';
import 'package:mobile_tp/screens/PageAventures.dart';
import 'package:mobile_tp/services/SqliteService.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final database = SqliteService().initializeDB();

  runApp(MysteryNumberApp(database: database));
  // NiveauDB niveauDB = NiveauDB(database: database);
  // niveauDB.add(Niveau(id:1, palier: 1, idDifficulte: 1));

  // print(await niveauDB.getAll());
}