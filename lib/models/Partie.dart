class Partie {

  final int id;
  final int score;
  final int nbMystere;
  final int nbEssais;
  final bool gagnee;
  final DateTime dateDebut;
  final DateTime dateFin;
  final int idAventure;
  final int idNiveau;

  Partie({
    required this.id,
    required this.score,
    required this.nbMystere,
    required this.nbEssais,
    required this.gagnee,
    required this.dateDebut,
    required this.dateFin,
    required this.idAventure,
    required this.idNiveau,
  });

  Map<String, dynamic> toMap(){
    return{
      'idPartie': id,
      'score': score,
      'nbMystere': nbMystere,
      'nbEssais': nbEssais,
      'gagnee': gagnee ? 1 : 0,
      'dateDebut': dateDebut.toIso8601String(),
      'dateFin': dateFin.toIso8601String(),
      'idAventure': idAventure,
      'idNiveau': idNiveau,
    };
  }
}