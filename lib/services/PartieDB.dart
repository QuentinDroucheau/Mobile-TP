import 'package:mobile_tp/models/Difficulte.dart';
import 'package:mobile_tp/models/Niveau.dart';
import 'package:mobile_tp/services/NiveauDB.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mobile_tp/models/Partie.dart';

class PartieDB {
  final Future<Database> database;

  PartieDB({required this.database});

  Future<int> add(Partie partie) async {
    final db = await database;
    final id = await db.insert(
      'Partie',
      partie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Partie>> getAll() async {
    final db = await database;
    final List<Map<String, Object?>> partieMaps = await db.query('Partie');
    return [
      for (final {
            'idPartie': id as int,
            'score': score as int,
            'nbMystere': nbMystere as int,
            'nbEssaisJoueur': nbEssaisJoueur as int,
            'gagne': gagne as int,
            'dateDebut': dateDebut as String,
            'dateFin': dateFin as String,
            'idAventure': idAventure as int,
            'idNiveau': idNiveau as int,
          } in partieMaps)
        Partie(
            id: id,
            score: score,
            nbMystere: nbMystere,
            nbEssaisJoueur: nbEssaisJoueur,
            gagne: gagne == 1,
            dateDebut: DateTime.parse(dateDebut),
            dateFin: DateTime.parse(dateFin),
            idAventure: idAventure,
            idNiveau: idNiveau)
    ];
  }

  Future<Niveau> getNiveau(Partie partie) async {
    NiveauDB niveauDB = NiveauDB(database: database);
    List<Niveau> niveaux = await niveauDB.getAll();
    return niveaux.firstWhere((niveau) => niveau.id == partie.idNiveau);
  }

  Future<Difficulte> getDifficulte(Partie partie) async {
    Niveau niveau = await getNiveau(partie);
    NiveauDB niveauDB = NiveauDB(database: database);
    return await niveauDB.getDifficulteById(niveau.idDifficulte);
  }

  Future<Partie> getById(int id) async {
    final db = await database;
    final maps = await db.query(
      'Partie',
      where: 'idPartie = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Partie.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<void> update(Partie partie) async {
    final db = await database;
    print('Updating Partie with values: ${partie.toMap()}');
    await db.update(
      'Partie',
      partie.toMap(),
      where: 'idPartie = ?',
      whereArgs: [partie.id],
    );
  }

  Future<List<Partie>> getPartiesWonForAventure(int idAventure) async {
    final db = await database;
    final List<Map<String, Object?>> partieMaps = await db.query(
      'Partie',
      where: 'idAventure = ? AND gagne = 1',
      whereArgs: [idAventure],
    );

    return List.generate(partieMaps.length, (i) {
      return Partie.fromMap(partieMaps[i]);
    });
  }
}
