class Difficulte {
  late int _id;
  late String _nomDifficulte;
  late int _nbTentatives;
  late int _valeurMax;

  Difficulte({required String nomDifficulte, required int nbTentatives, required int valeurMax}){
    _nomDifficulte = nomDifficulte;
    _nbTentatives = nbTentatives;
    _valeurMax = valeurMax;
  }

  Difficulte.fromMap(Map<String, dynamic> item){
    _id = item['id'];
    _nomDifficulte = item['nomDifficulte'];
    _nbTentatives = item['nbTentatives'];
    _valeurMax = item['valeurMax'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id': _id,
      'nomDifficulte': _nomDifficulte,
      'nbTentatives': _nbTentatives,
      'valeurMax': _valeurMax,
    };
  }

  int get id => _id;

  String get nomDifficulte => _nomDifficulte;

  set nomDifficulte(String nomDifficulte){
    _nomDifficulte = nomDifficulte;
  }

  int get nbTentatives => _nbTentatives;

  set nbTentatives(int nbTentatives){
    _nbTentatives = nbTentatives;
  }

  int get valeurMax => _valeurMax;

  set valeurMax(int valeurMax){
    _valeurMax = valeurMax;
  }

  @override
  String toString() {
    return 'Difficulte{id: $_id, nomDifficulte: $_nomDifficulte, nbTentatives: $_nbTentatives, valeurMax: $_valeurMax}';
  }
}