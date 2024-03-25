class Aventure {
  late int _id;
  late String _nomJoueur;

  Aventure({required String nomJoueur}) {
    _nomJoueur = nomJoueur;
  }

  Aventure.fromMap(Map<String, dynamic> item) {
    _id = item['id'];
    _nomJoueur = item['nomJoueur'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'nomJoueur': _nomJoueur,
    };
  }

  int get id => _id;

  String get nomJoueur => _nomJoueur;

  set nomJoueur(String nomJoueur) {
    _nomJoueur = nomJoueur;
  }

  @override
  String toString() {
    return 'Aventure{id: $_id, nomJoueur: $_nomJoueur}';
  }

}