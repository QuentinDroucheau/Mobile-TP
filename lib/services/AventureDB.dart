import 'package:mobile_tp/models/Aventure.dart';
import 'package:sqflite/sqflite.dart';

class AventureDB {
  final Future<Database> database;

  AventureDB({required this.database});

  Future<void> add(String nom) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO Aventure(nomJoueur) VALUES(?)',
        [nom],
      );
    });
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
}
