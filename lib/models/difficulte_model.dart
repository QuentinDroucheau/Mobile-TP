class Difficulte{

  late int id;
  late String nomDifficulte;
  late int nbTentatives;
  late int valeurMax;

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