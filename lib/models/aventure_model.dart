class Aventure{

  late int id;
  late String nomJoueur;

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