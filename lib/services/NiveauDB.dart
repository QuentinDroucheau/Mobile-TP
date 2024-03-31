import 'package:mobile_tp/models/Difficulte.dart';
import 'package:mobile_tp/models/Niveau.dart';
import 'package:mobile_tp/services/SqliteService.dart';
import 'package:sqflite/sqflite.dart';

class NiveauDB {
  final Future<Database> database;

  NiveauDB({required this.database});

  Future<void> add(Niveau niveau) async {
    final db = await database;
    await db.insert(
      'Niveau',
      niveau.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Niveau>> getAll() async {
    final db = await database;
    final List<Map<String, Object?>> niveauMaps = await db.query('Niveau');

    return List.generate(niveauMaps.length, (i) {
      return Niveau(
        id: niveauMaps[i]['idNiveau'] as int,
        palier: niveauMaps[i]['palier'] as int,
        idDifficulte: niveauMaps[i]['idDifficulte'] as int,
        idAventure: niveauMaps[i]['idAventure'] as int,
      );
    });
  }

  Future<Difficulte> getDifficulteById(int id) async {
    final db = await database;
    final List<Map<String, Object?>> difficulteMaps = await db
        .query('Difficulte', where: 'idDifficulte = ?', whereArgs: [id]);

    if (difficulteMaps.isEmpty) {
      throw Exception('No difficulty found with id $id');
    }

    return Difficulte(
        id: difficulteMaps[0]['idDifficulte'] as int,
        nomDifficulte: difficulteMaps[0]['nom'] as String,
        nbTentatives: difficulteMaps[0]['nbTentative'] as int,
        valeurMax: difficulteMaps[0]['valeurMax'] as int);
  }

  Future<Niveau> getById(int id) async {
    final db = await database;
    final List<Map<String, Object?>> niveauMaps = await db
        .query('Niveau', where: 'idNiveau = ?', whereArgs: [id]);

    if (niveauMaps.isEmpty) {
      throw Exception('No level found with id $id');
    }

    return Niveau(
      id: niveauMaps[0]['idNiveau'] as int,
      palier: niveauMaps[0]['palier'] as int,
      idDifficulte: niveauMaps[0]['idDifficulte'] as int,
      idAventure: niveauMaps[0]['idAventure'] as int,
    );
  }
}
