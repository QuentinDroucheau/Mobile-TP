class Niveau{

  late int id;
  late int palier;
  late int idDifficulte;
  late int idAventure;
  late bool complete;
  
  Niveau({
    required this.id,
    required this.palier,
    required this.idDifficulte,
    required this.idAventure,
    this.complete = false
  });

  Map<String, Object?> toMap(){
    return {
      'idNiveau': id,
      'palier': palier,
      'idDifficulte': idDifficulte,
      'idAventure': idAventure,
    };
  }

  factory Niveau.fromMap(Map<String, dynamic> map) {
    return Niveau(
      id: map['idNiveau'],
      palier: map['palier'],
      idDifficulte: map['idDifficulte'],
      idAventure: map['idAventure'],
    );
  }
}