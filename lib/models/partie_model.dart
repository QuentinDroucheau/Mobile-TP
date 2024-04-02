class Partie {
  
  late int? id;
  late int score;
  late int nbMystere;
  late int nbEssaisJoueur;
  late bool gagne;
  late DateTime dateDebut;
  late DateTime? dateFin;
  late int idAventure;
  late int idNiveau;

  Partie({
    this.id,
    required this.score,
    required this.nbMystere,
    required this.nbEssaisJoueur,
    required this.gagne,
    required this.dateDebut,
    this.dateFin,
    required this.idAventure,
    required this.idNiveau,
  });

  Map<String, dynamic> toMap() {
    return {
      'idPartie': id,
      'score': score,
      'nbMystere': nbMystere,
      'nbEssaisJoueur': nbEssaisJoueur,
      'gagne': gagne ? 1 : 0,
      'dateDebut': dateDebut.toString(),
      'dateFin': dateFin == null ? null : dateFin.toString(),
      'idAventure': idAventure,
      'idNiveau': idNiveau,
    };
  }
}
