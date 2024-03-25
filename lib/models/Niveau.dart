class Niveau {
  late int _id;
  late int _palier;
  late int _idDifficulte;

  Niveau({required int palier, required int idDifficulte}){
    _palier = palier;
    _idDifficulte = idDifficulte;
  }

  Niveau.fromMap(Map<String, dynamic> item){
    _id = item['id'];
    _palier = item['palier'];
    _idDifficulte = item['idDifficulte'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id': _id,
      'palier': _palier,
      'idDifficulte': _idDifficulte,
    };
  }

  int get id => _id;

  int get palier => _palier;

  set palier(int palier){
    _palier = palier;
  }

  int get idDifficulte => _idDifficulte;

  set idDifficulte(int idDifficulte){
    _idDifficulte = idDifficulte;
  }

  @override
  String toString() {
    return 'Niveau{id: $_id, palier: $_palier, idDifficulte: $_idDifficulte}';
  }
}