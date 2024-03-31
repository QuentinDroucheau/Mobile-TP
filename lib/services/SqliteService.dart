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
}
