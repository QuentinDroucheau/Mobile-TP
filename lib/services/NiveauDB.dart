import 'package:mobile_tp/models/Niveau.dart';
import 'package:mobile_tp/services/SqliteService.dart';
import 'package:sqflite/sqflite.dart';

class NiveauDB{

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

  Future<List<Niveau>> getAll() async{
    final db = await database;
    final List<Map<String, Object?>> niveauMaps = await db.query('Niveau');
    return [
      for (final{
        'idNiveau': id as int,
        'palier': palier as int,
        'idDifficulte': idDifficule as int
      } in niveauMaps)
        Niveau(id: id, palier: palier, idDifficulte: idDifficule)
    ];
  }
}