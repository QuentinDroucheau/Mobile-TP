import 'package:sqflite/sqflite.dart';
import 'package:mobile_tp/models/Effectuer.dart';

class EffectuerDB {
  final Future<Database> database;

  EffectuerDB({required this.database});

  Future<void> add(Effectuer effectuer) async {
    final db = await database;
    print('Adding Effectuer with values: ${effectuer.toMap()}');
    try {
      await db.insert(
        'Effectuer',
        effectuer.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Failed to add Effectuer: $e');
    }
  }

  Future<List<Effectuer>> getAll() async {
    final db = await database;
    final List<Map<String, Object?>> effectuerMaps =
        await db.query('Effectuer');
    return [
      for (final {
            'idAventure': idAventure as int,
            'idNiveau': idNiveau as int,
            'idPartie': idPartie as int,
            'complete': complete as int,
          } in effectuerMaps)
        Effectuer(
            idAventure: idAventure,
            idNiveau: idNiveau,
            idPartie: idPartie,
            complete: complete == 1)
    ];
  }
}
