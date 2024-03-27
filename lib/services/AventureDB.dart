import 'package:mobile_tp/models/Aventure.dart';
import 'package:sqflite/sqflite.dart';

class AventureDB {
  final Future<Database> database;

  AventureDB({required this.database});

  Future<int> add(String nomJoueur) async {
    final db = await database;
    return await db.rawInsert(
      'INSERT INTO Aventure(nomJoueur) VALUES(?)',
      [nomJoueur],
    );
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
