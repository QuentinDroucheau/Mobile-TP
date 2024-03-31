class Partie {
  final int? id;
  final int score;
  final int nbMystere;
  final int nbEssaisJoueur;
  bool gagne;
  final DateTime dateDebut;
  final DateTime dateFin;
  final int idAventure;
  final int idNiveau;

  Partie({
    this.id,
    required this.score,
    required this.nbMystere,
    required this.nbEssaisJoueur,
    required this.gagne,
    required this.dateDebut,
    required this.dateFin,
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
      'dateDebut': dateDebut.toIso8601String(),
      'dateFin': dateFin.toIso8601String(),
      'idAventure': idAventure,
      'idNiveau': idNiveau,
    };
  }

  factory Partie.fromMap(Map<String, dynamic> map) {
    return Partie(
      id: map['idPartie'],
      score: map['score'],
      nbMystere: map['nbMystere'],
      nbEssaisJoueur: map['nbEssaisJoueur'],
      gagne: map['gagne'] == 1,
      dateDebut: DateTime.parse(map['dateDebut']),
      dateFin: DateTime.parse(map['dateFin']),
      idAventure: map['idAventure'],
      idNiveau: map['idNiveau'],
    );
  }

  void setGagne (bool gagne) {
    this.gagne = gagne;
  }

  @override
  String toString() {
    return 'Partie{id: $id, score: $score, nbMystere: $nbMystere, nbEssaisJoueur: $nbEssaisJoueur, gagne: $gagne, dateDebut: $dateDebut, dateFin: $dateFin, idAventure: $idAventure, idNiveau: $idNiveau}';
  }
}
