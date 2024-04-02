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

  runApp(MysteryNumberApp(database: database));
}

final database = SqliteService().initializeDB();