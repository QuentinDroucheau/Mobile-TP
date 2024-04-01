import 'package:mobile_tp/models/Partie.dart';
import 'package:mobile_tp/screens/HistoriquePage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
            idAventure INTEGER NOT NULL,
            FOREIGN KEY(idDifficulte) REFERENCES Difficulte(idDifficulte),
            FOREIGN KEY(idAventure) REFERENCES Aventure(idAventure)
          )
        """);
    await db.execute("""
          CREATE TABLE Partie (
            idPartie INTEGER PRIMARY KEY AUTOINCREMENT, 
            score INTEGER NOT NULL, 
            nbMystere INTEGER NOT NULL, 
            nbEssaisJoueur INTEGER NOT NULL, 
            gagne INTEGER NOT NULL, 
            dateDebut TEXT NOT NULL, 
            dateFin TEXT NOT NULL,
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
      version: 3,
    );
  }

  Future<List<Partie>> getHistorique() async {
    final db = await initializeDB();
          
    List<Partie> historique = [];
    
    for (int i = 0; i <= 10; i++) {
      Partie partie = Partie(
        id: i,
        score: i,
        nbMystere: i,
        nbEssaisJoueur: i,
        gagne: i % 2 == 0,
        dateDebut: DateTime(2021, 9, i),
        dateFin: DateTime(2021, 9, i),
        idAventure: i,
        idNiveau: i
      );
      
      historique.add(partie);
    }
    
    return historique;
  }
}
