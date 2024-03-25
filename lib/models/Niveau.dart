class Niveau{

  final int id;
  final int palier;
  final int idDifficulte;

  Niveau({
    required this.id,
    required this.palier,
    required this.idDifficulte,
  });

  Map<String, Object?> toMap(){
    return {
      'idNiveau': id,
      'palier': palier,
      'idDifficulte': idDifficulte,
    };
  }
}