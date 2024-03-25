class Difficulte{

  final int id;
  final int nomDifficulte;
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
      'nomDifficulte': nomDifficulte,
      'nbTentatives': nbTentatives,
      'valeurMax': valeurMax,
    };
  }
}