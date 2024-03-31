import 'package:mobile_tp/models/Aventure.dart';
import 'package:mobile_tp/models/Niveau.dart';
import 'package:mobile_tp/models/Partie.dart';
import 'package:mobile_tp/services/NiveauDB.dart';
import 'package:sqflite/sqflite.dart';

class AventureDB {
  final Future<Database> database;

  AventureDB({required this.database});

  Future<int> add(String nomJoueur) async {
    final db = await database;
    final id = await db.insert(
      'Aventure',
      Aventure(nomJoueur: nomJoueur).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    NiveauDB niveauDB = NiveauDB(database: database);
    for (int i = 1; i <= 10; i++) {
      int idDifficulte;
      if (i <= 3) {
        idDifficulte = 1;
      } else if (i <= 7) {
        idDifficulte = 2;
      } else {
        idDifficulte = 3;
      }
      await niveauDB
          .add(Niveau(palier: i, idDifficulte: idDifficulte, idAventure: id));
    }

    return id;
  }

  Future<List<Aventure>> getAll() async {
    final db = await database;
    final List<Map<String, Object?>> aventureMaps = await db.query('Aventure');
    return [
      for (final {
            'idAventure': id as int,
            'nomJoueur': nom as String,
          } in aventureMaps)
        Aventure(id: id, nomJoueur: nom)
    ];
  }

  Future<List<Niveau>> getLevelsWon(int idAventure) async {
    final db = await database;
    final List<Map<String, Object?>> levelsMaps = await db.rawQuery('''
    SELECT Niveau.idNiveau, Niveau.palier, Niveau.idDifficulte
    FROM Niveau
    JOIN Partie ON Partie.idNiveau = Niveau.idNiveau
    WHERE Partie.idAventure = ? AND Partie.gagne = 1
  ''', [idAventure]);
    return [
      for (final {
            'idNiveau': id as int,
            'palier': palier as int,
            'idDifficulte': idDifficulte as int,
          } in levelsMaps)
        Niveau(
            palier: palier, idDifficulte: idDifficulte, idAventure: idAventure)
    ];
  }

  Future<List<Niveau>> getLevelsOfAdventure(int idAventure) async {
    final db = await database;
    final List<Map<String, Object?>> levelsMaps = await db
        .query('Niveau', where: 'idAventure = ?', whereArgs: [idAventure]);
    return [
      for (final {
            'idNiveau': id as int,
            'palier': palier as int,
            'idDifficulte': idDifficule as int,
          } in levelsMaps)
        Niveau(
            palier: palier, idDifficulte: idDifficule, idAventure: idAventure)
    ];
  }

  // Future<int> getNextLevel(int idAventure) async {
  //   final db = await database;
  //   final List<Map<String, Object?>> levelsMaps = await db.rawQuery('''
  //   SELECT Niveau.idNiveau, Niveau.palier, Niveau.idDifficulte
  //   FROM Niveau
  //   JOIN Partie ON Partie.idNiveau = Niveau.idNiveau
  //   WHERE Partie.idAventure = ? AND Partie.gagne = 1
  //   ORDER BY Niveau.palier DESC
  //   LIMIT 1
  // ''', [idAventure]);
  //   if (levelsMaps.isEmpty) {
  //     return 1;
  //   }
  //   return levelsMaps.first['palier'] as int + 1;
  // }
}
