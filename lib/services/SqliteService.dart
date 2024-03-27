import 'package:mobile_tp/models/Partie.dart';
import 'package:mobile_tp/screens/HistoriquePage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService{

  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    
    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version){
        database.execute("CREATE TABLE Aventure (idAventure INTEGER PRIMARY KEY AUTOINCREMENT, nomJoueur TEXT NOT NULL)");
        database.execute("CREATE TABLE Niveau (idNiveau INTEGER PRIMARY KEY AUTOINCREMENT, palier INTEGER NOT NULL, idDifficulte INTEGER NOT NULL)");
        database.execute("CREATE TABLE Difficulte (idDifficulte INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT NOT NULL, nbTentative INTEGER NOT NULL, valeurMax INTEGER NOT NULL)");
        database.execute("CREATE TABLE Partie (idPartie INTEGER PRIMARY KEY AUTOINCREMENT, score INTEGER NOT NULL, nbMystere INTEGER NOT NULL, nbEssaisJoueur INTEGER NOT NULL, gagne INTEGER NOT NULL, dateDebut TEXT NOT NULL, dateFin TEXT NOT NULL)");
        return database.execute("CREATE TABLE Effectuer (idAventure INTEGER NOT NULL, idPartie INTEGER NOT NULL, idNiveau INTEGER NOT NULL, complete INTEGER NOT NULL)");
      },
      version: 1,
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
        nbEssais: i,
        gagnee: i % 2 == 0,
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