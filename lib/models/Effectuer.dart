class Effectuer{

  final int idAventure;
  final int idNiveau;
  final int idPartie;
  final bool complete;

  Effectuer({
    required this.idAventure,
    required this.idNiveau,
    required this.idPartie,
    required this.complete,
  });

  Map<String, dynamic> toMap(){
    return {
      'idAventure': idAventure,
      'idNiveau': idNiveau,
      'idPartie': idPartie,
      'complete': complete ? 1 : 0,
    };
  }
}