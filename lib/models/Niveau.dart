class Niveau{

  final int? id;
  final int palier;
  final int idDifficulte;
  final int idAventure;

  Niveau({
    this.id,
    required this.palier,
    required this.idDifficulte,
    required this.idAventure,
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