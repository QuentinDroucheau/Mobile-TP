import 'package:flutter/widgets.dart';
import 'package:mobile_tp/models/Niveau.dart';
import 'package:mobile_tp/models/db/NiveauDB.dart';
import 'package:mobile_tp/screens/MysteryNumberApp.dart';
import 'package:mobile_tp/screens/PageAventures.dart';
import 'package:mobile_tp/services/SqliteService.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main(){
  runApp(MysteryNumberApp(),);
  // WidgetsFlutterBinding.ensureInitialized();

  // final database = SqliteService().initializeDB();
  // NiveauDB niveauDB = NiveauDB(database: database);
  // niveauDB.add(Niveau(palier: 1, idDifficulte: 1));

  // print(await niveauDB.getAll());
}