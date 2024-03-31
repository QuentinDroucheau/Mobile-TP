class Difficulte{

  final int id;
  final String nomDifficulte;
  final int nbTentatives;
  final int valeurMax;

  Difficulte({
    required this.id,
    required this.nomDifficulte,
    required this.nbTentatives,
    required this.valeurMax,
  });

  Map<String, dynamic> toMap(){
    return {
      'idDifficulte': id,
      'nom': nomDifficulte,
      'nbTentative': nbTentatives,
      'valeurMax': valeurMax,
    };
  }
}