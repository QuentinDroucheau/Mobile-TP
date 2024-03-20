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

}