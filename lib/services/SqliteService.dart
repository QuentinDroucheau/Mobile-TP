import 'package:mobile_tp/models/Difficulte.dart';
import 'package:mobile_tp/models/Niveau.dart';
import 'package:mobile_tp/models/Partie.dart';
import 'package:mobile_tp/screens/HistoriquePage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';

class SqliteService {
  Future<void> onCreate(Database db, int version) async {
    await db.execute("""
          CREATE TABLE Aventure (
            idAventure INTEGER PRIMARY KEY AUTOINCREMENT, 
            nomJoueur TEXT NOT NULL
          )
        """);
    await db.execute("""
          CREATE TABLE Difficulte (
            idDifficulte INTEGER PRIMARY KEY AUTOINCREMENT, 
            nom TEXT NOT NULL, 
            nbTentative INTEGER NOT NULL, 
            valeurMax INTEGER NOT NULL
          )
        """);
    await db.execute("""
          CREATE TABLE Niveau (
            idNiveau INTEGER PRIMARY KEY AUTOINCREMENT, 
            palier INTEGER NOT NULL, 
            idDifficulte INTEGER NOT NULL,
            FOREIGN KEY(idDifficulte) REFERENCES Difficulte(idDifficulte)
          )
        """);
    await db.execute("""
          CREATE TABLE Partie (
            idPartie INTEGER PRIMARY KEY AUTOINCREMENT, 
            score INTEGER, 
            nbMystere INTEGER NOT NULL, 
            nbEssaisJoueur INTEGER NOT NULL, 
            gagne INTEGER, 
            dateDebut TEXT NOT NULL, 
            dateFin TEXT DEFAULT NULL,
            idAventure INTEGER,
            idNiveau INTEGER,
            FOREIGN KEY(idAventure) REFERENCES Aventure(idAventure),
            FOREIGN KEY(idNiveau) REFERENCES Niveau(idNiveau)
          )
        """);
    await db.execute("""
          CREATE TABLE Effectuer (
            idAventure INTEGER NOT NULL, 
            idPartie INTEGER NOT NULL, 
            idNiveau INTEGER NOT NULL, 
            complete INTEGER NOT NULL,
            PRIMARY KEY(idAventure, idPartie, idNiveau),
            FOREIGN KEY(idAventure) REFERENCES Aventure(idAventure),
            FOREIGN KEY(idPartie) REFERENCES Partie(idPartie),
            FOREIGN KEY(idNiveau) REFERENCES Niveau(idNiveau)
          )
        """);
      await db.execute("""
          INSERT INTO Difficulte (nom, nbTentative, valeurMax) VALUES ('Facile', 20, 50)
          """);
      await db.execute("""
          INSERT INTO Difficulte (nom, nbTentative, valeurMax) VALUES ('Moyen', 15, 150)
          """);
      await db.execute("""
          INSERT INTO Difficulte (nom, nbTentative, valeurMax) VALUES ('Difficile', 10, 300)
          """);
      await db.execute("""
          INSERT INTO Niveau (palier, idDifficulte) VALUES (1, 1)
          """);
      await db.execute("""
          INSERT INTO Niveau (palier, idDifficulte) VALUES (2, 1)
          """);
      await db.execute("""
          INSERT INTO Niveau (palier, idDifficulte) VALUES (3, 1)
          """);
      await db.execute("""
          INSERT INTO Niveau (palier, idDifficulte) VALUES (4, 1)
          """);
      await db.execute("""
          INSERT INTO Niveau (palier, idDifficulte) VALUES (5, 1)
          """);
      await db.execute("""
          INSERT INTO Niveau (palier, idDifficulte) VALUES (6, 1)
          """);
      await db.execute("""
          INSERT INTO Niveau (palier, idDifficulte) VALUES (7, 1)
          """);
      await db.execute("""
          INSERT INTO Niveau (palier, idDifficulte) VALUES (8, 1)
          """);
      await db.execute("""
          INSERT INTO Niveau (palier, idDifficulte) VALUES (9, 1)
          """);
      await db.execute("""
          INSERT INTO Niveau (palier, idDifficulte) VALUES (10, 1)
          """);
      await db.execute("""
          INSERT INTO Niveau (palier, idDifficulte) VALUES (11, 1)
          """);
      await db.execute("""
          INSERT INTO Niveau (palier, idDifficulte) VALUES (12, 1)
          """);
      await db.execute("""
          INSERT INTO Aventure (nomJoueur) VALUES ('Joueur 1')
        """);
      await db.execute("""
          INSERT INTO Partie (score, nbMystere, nbEssaisJoueur, gagne, dateDebut, dateFin, idAventure, idNiveau) VALUES (0, 25, 20, 1, '2021-01-01 00:00:00', '2021-01-01 00:00:00', 1, 1)
        """);
      await db.execute("""
          INSERT INTO Partie (score, nbMystere, nbEssaisJoueur, gagne, dateDebut, dateFin, idAventure, idNiveau) VALUES (0, 25, 20, 1, '2021-01-01 00:00:00', '2021-01-01 00:00:00', 1, 2)
        """);
      await db.execute("""
          INSERT INTO Partie (score, nbMystere, nbEssaisJoueur, gagne, dateDebut, dateFin, idAventure, idNiveau) VALUES (0, 25, 20, 1, '2021-01-01 00:00:00', '2021-01-01 00:00:00', 1, 3)
        """);
      await db.execute("""
          INSERT INTO Partie (score, nbMystere, nbEssaisJoueur, gagne, dateDebut, dateFin, idAventure, idNiveau) VALUES (0, 25, 20, 1, '2021-01-01 00:00:00', '2021-01-01 00:00:00', 1, 4)
        """);
  }

  Future<Database> initializeDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'aventure.db'),
      onCreate: onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        // Supprime les tables
        await db.execute("DROP TABLE IF EXISTS Aventure");
        await db.execute("DROP TABLE IF EXISTS Difficulte");
        await db.execute("DROP TABLE IF EXISTS Niveau");
        await db.execute("DROP TABLE IF EXISTS Partie");
        await db.execute("DROP TABLE IF EXISTS Effectuer");

        // Recrée les tables
        await onCreate(db, newVersion);

        print('Database upgraded from $oldVersion to $newVersion');
      },
      version: 14,
    );
  }

  Future<Partie> getPartie(int idAventure, int idNiveau)async{
    final db = await SqliteService().initializeDB();

    print(await db.query("Partie"));

    final List<Map<String, Object?>> dernierePartie = await db.rawQuery("""
      SELECT *
      FROM Partie
      WHERE idAventure = ? AND idNiveau = ? AND dateFin IS NULL
      ORDER BY dateDebut DESC LIMIT 1
    """, [idAventure, idNiveau]);

    if(dernierePartie.isEmpty){
      Difficulte difficulte = await getDifficulte(idNiveau);
      Random random = Random();
      int nbMystere = random.nextInt(difficulte.valeurMax) + 1;

      return Partie(
        score: 0,
        nbMystere: nbMystere+200,
        nbEssaisJoueur: 0,
        gagne: false,
        dateDebut: DateTime.now(),
        dateFin: null,
        idAventure: idAventure,
        idNiveau: idNiveau,
      );

    }else{

      return Partie(
        id: dernierePartie[0]['idPartie'] as int,
        score: dernierePartie[0]['score'] as int,
        nbMystere: dernierePartie[0]['nbMystere'] as int,
        nbEssaisJoueur: dernierePartie[0]['nbEssaisJoueur'] as int,
        gagne: dernierePartie[0]['gagne'] as int == 1,
        dateDebut: DateTime.parse(dernierePartie[0]['dateDebut'] as String),
        dateFin: dernierePartie[0]['dateFin'] == null ? DateTime.now() : DateTime.parse(dernierePartie[0]['dateFin'] as String),
        idAventure: dernierePartie[0]['idAventure'] as int,
        idNiveau: dernierePartie[0]['idNiveau'] as int,
      );
    }
  }

  Future<Difficulte> getDifficulte(int idNiveau)async{
    final db = await SqliteService().initializeDB();

    final List<Map<String, Object?>> difficulte = await db.rawQuery("""
      select *
      from Niveau
      natural join Difficulte
      where idNiveau = ?
    """, [idNiveau]);

    Difficulte d = Difficulte(
      id: 1,
      nomDifficulte: 'Facile',
      nbTentatives: 20,
      valeurMax: 100,
    );

    for(final difficulteElement in difficulte){
      int idDifficulte = difficulteElement['idDifficulte'] as int;
      String nom = difficulteElement['nom'] as String;
      int nbTentatives = difficulteElement['nbTentative'] as int;
      int valeurMax = difficulteElement['valeurMax'] as int;

      d = Difficulte(
        id: idDifficulte,
        nomDifficulte: nom,
        nbTentatives: nbTentatives,
        valeurMax: valeurMax,
      );
    }

    return d;
  }

  Future<void> addPartie(Partie partie)async{
    final db = await SqliteService().initializeDB();

    print(partie.toMap());

    await db.insert(
      'Partie',
      partie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Niveau>> getNiveaux(int idAventure)async{
    final db = await SqliteService().initializeDB();

    final List<Map<String, Object?>> niveauxIdComplete = await db.rawQuery("""
      select distinct idNiveau
      from Partie
      where idAventure = ? and gagne = ?
    """, [idAventure, 1]);

    List<int> idNiveauxComplete = [];
    for(final{'idNiveau': idNiveau as int} in niveauxIdComplete){
      idNiveauxComplete.add(idNiveau);
    }

    final List<Map<String, Object?>> niveauMaps = await db.query('Niveau');
    List<Niveau> niveaux = [];
    for(final{'idNiveau': id as int, 'palier': palier as int, 'idDifficulte': idDifficulte as int} in niveauMaps){
      niveaux.add(Niveau(
        id: id,
        palier: palier,
        idDifficulte: idDifficulte,
        idAventure: 1,
        complete: idNiveauxComplete.contains(id),
      ));
    }
    return niveaux;
  }

  Future<List<Partie>> getHistorique() async {
    final db = await SqliteService().initializeDB();
    
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
}
