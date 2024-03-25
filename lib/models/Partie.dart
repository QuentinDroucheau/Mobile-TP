class Partie {
  late int _id, _score, _nbMystere, _nbEssais;
  late bool _gagnee;
  late DateTime _dateDebut, _dateFin;
  late int _idAventure, _idNiveau;

  Partie({required int score, required int nbMystere, required int nbEssais, required bool gagnee, required DateTime _dateDebut, required DateTime _dateFin, required int idAventure, required int idNiveau}) {
    _score = score;
    _nbMystere = nbMystere;
    _nbEssais = nbEssais;
    _gagnee = gagnee;
    _dateDebut = _dateDebut;
    _dateFin = _dateFin;
    _idAventure = idAventure;
    _idNiveau = idNiveau;
  }

  Partie.fromMap(Map<String, dynamic> item) {
    _id = item['id'];
    _score = item['score'];
    _nbMystere = item['nbMystere'];
    _nbEssais = item['nbEssais'];
    _gagnee = item['gagnee'] == 1;
    _dateDebut = DateTime.parse(item['dateDebut']);
    _dateFin = DateTime.parse(item['dateFin']);
    _idAventure = item['idAventure'];
    _idNiveau = item['idNiveau'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'score': _score,
      'nbMystere': _nbMystere,
      'nbEssais': _nbEssais,
      'gagnee': _gagnee ? 1 : 0,
      'dateDebut': _dateDebut.toIso8601String(),
      'dateFin': _dateFin.toIso8601String(),
      'idAventure': _idAventure,
      'idNiveau': _idNiveau,
    };
  }

  int get id => _id;

  int get score => _score;

  set score(int score) {
    _score = score;
  }

  int get nbMystere => _nbMystere;

  set nbMystere(int nbMystere) {
    _nbMystere = nbMystere;
  }

  int get nbEssais => _nbEssais;

  set nbEssais(int nbEssais) {
    _nbEssais = nbEssais;
  }

  bool get gagnee => _gagnee;

  set gagnee(bool gagnee) {
    _gagnee = gagnee;
  }

  DateTime get dateDebut => _dateDebut;

  set dateDebut(DateTime dateDebut) {
    _dateDebut = dateDebut;
  }

  DateTime get dateFin => _dateFin;

  set dateFin(DateTime dateFin) {
    _dateFin = dateFin;
  }

  int get idAventure => _idAventure;

  set idAventure(int idAventure) {
    _idAventure = idAventure;
  }

  int get idNiveau => _idNiveau;

  set idNiveau(int idNiveau) {
    _idNiveau = idNiveau;
  }

  @override
  String toString() {
    return 'Partie{id: $_id, score: $_score, nbMystere: $_nbMystere, nbEssais: $_nbEssais, gagnee: $_gagnee, dateDebut: $_dateDebut, dateFin: $_dateFin, idAventure: $_idAventure, idNiveau: $_idNiveau}';
  }
}