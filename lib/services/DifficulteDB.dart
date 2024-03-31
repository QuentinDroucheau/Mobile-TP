import 'package:sqflite/sqflite.dart';
import 'package:mobile_tp/models/Difficulte.dart';

class DifficulteDB {
  final Future<Database> database;

  DifficulteDB({required this.database});

  Future<void> add(Difficulte difficulte) async {
    final db = await database;
    await db.insert(
      'Difficulte',
      difficulte.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Difficulte>> getAll() async {
    final db = await database;
    final List<Map<String, Object?>> difficulteMaps = await db.query('Difficulte');
    return [
      for (final {
            'idDifficulte': id as int,
            'nom': nom as String,
            'nbTentative': nbTentatives as int,
            'valeurMax': valeurMax as int,
          } in difficulteMaps)
        Difficulte(id: id, nomDifficulte: nom, nbTentatives: nbTentatives, valeurMax: valeurMax)
    ];
  }

  Future<Difficulte> getById(int id) async {
    final db = await database;
    final List<Map<String, Object?>> difficulteMaps = await db.query(
      'Difficulte',
      where: 'idDifficulte = ?',
      whereArgs: [id],
    );
    return Difficulte(
      id: difficulteMaps[0]['idDifficulte'] as int,
      nomDifficulte: difficulteMaps[0]['nom'] as String,
      nbTentatives: difficulteMaps[0]['nbTentative'] as int,
      valeurMax: difficulteMaps[0]['valeurMax'] as int,
    );
  }
}