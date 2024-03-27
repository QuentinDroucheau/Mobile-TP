import 'package:sqflite/sqflite.dart';
import 'package:mobile_tp/models/Partie.dart';

class PartieDB {
  final Future<Database> database;
  
  PartieDB({required this.database});

  Future<void> add(Partie partie) async {
    final db = await database;
    await db.insert(
      'Partie',
      partie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Partie>> getAll() async {
    final db = await database;
    final List<Map<String, Object?>> partieMaps = await db.query('Partie');
    return [
      for (final {
            'idPartie': id as int,
            'score': score as int,
            'nbMystere': nbMystere as int,
            'nbEssais': nbEssais as int,
            'gagnee': gagnee as int,
            'dateDebut': dateDebut as String,
            'dateFin': dateFin as String,
            'idAventure': idAventure as int,
            'idNiveau': idNiveau as int,
          } in partieMaps)
        Partie(id: id, score: score, nbMystere: nbMystere, nbEssais: nbEssais, gagnee: gagnee == 1, dateDebut: DateTime.parse(dateDebut), dateFin: DateTime.parse(dateFin), idAventure: idAventure, idNiveau: idNiveau)
    ];
  }
}