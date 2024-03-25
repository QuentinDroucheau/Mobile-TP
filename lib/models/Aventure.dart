class Aventure{

  final int id;
  final String nomJoueur;

  Aventure({
    required this.id,
    required this.nomJoueur,
  });

  Map<String, dynamic> toMap(){
    return{
      'idAventure': id,
      'nomJoueur': nomJoueur,
    };
  }
}