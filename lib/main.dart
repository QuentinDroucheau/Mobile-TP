import 'package:flutter/widgets.dart';
import 'package:mobile_tp/models/Difficulte.dart';
import 'package:mobile_tp/models/Niveau.dart';
import 'package:mobile_tp/services/DifficulteDB.dart';
import 'package:mobile_tp/services/NiveauDB.dart';
import 'package:mobile_tp/screens/MysteryNumberApp.dart';
import 'package:mobile_tp/screens/PageAventures.dart';
import 'package:mobile_tp/services/SqliteService.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = SqliteService().initializeDB();

  runApp(MysteryNumberApp(database: database));
  Difficulte facile = Difficulte(
      id: 1, nomDifficulte: 'Facile', nbTentatives: 20, valeurMax: 50);
  Difficulte moyen = Difficulte(
      id: 2, nomDifficulte: 'Moyen', nbTentatives: 15, valeurMax: 150);
  Difficulte difficile = Difficulte(
      id: 3, nomDifficulte: 'Difficile', nbTentatives: 10, valeurMax: 300);
  DifficulteDB difficulteDB = DifficulteDB(database: database);
  await difficulteDB.add(facile);
  await difficulteDB.add(moyen);
  await difficulteDB.add(difficile);
}
