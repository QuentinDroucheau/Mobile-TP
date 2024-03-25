class Effectuer {
  late int _idAventure;
  late int _idNiveau;
  late int _idPartie;
  late bool _complete;

  Effectuer({required int idAventure, required int idNiveau, required int idPartie, required bool complete}){
    _idAventure = idAventure;
    _idNiveau = idNiveau;
    _idPartie = idPartie;
    _complete = complete;
  }

  Effectuer.fromMap(Map<String, dynamic> item){
    _idAventure = item['idAventure'];
    _idNiveau = item['idNiveau'];
    _idPartie = item['idPartie'];
    _complete = item['complete'] == 1;
  }

  Map<String, dynamic> toMap(){
    return {
      'idAventure': _idAventure,
      'idNiveau': _idNiveau,
      'idPartie': _idPartie,
      'complete': _complete ? 1 : 0,
    };
  }

  int get idAventure => _idAventure;

  int get idNiveau => _idNiveau;

  int get idPartie => _idPartie;

  bool get complete => _complete;

  set complete(bool complete){
    _complete = complete;
  }

  @override
  String toString() {
    return 'Effectuer{idAventure: $_idAventure, idNiveau: $_idNiveau, idPartie: $_idPartie, complete: $_complete}';
  }
}