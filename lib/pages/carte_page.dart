import 'package:flutter/material.dart';
import 'package:mobile_tp/models/aventure_model.dart';
import 'package:mobile_tp/models/niveau_model.dart';
import 'package:mobile_tp/pages/aventures_page.dart';
import 'package:mobile_tp/services/sqflite_service.dart';
import 'package:mobile_tp/widgets/niveau_widget.dart';

class CartePage extends StatefulWidget{

  final Aventure aventure;

  const CartePage({
    Key? key,
    required this.aventure,
  }) : super(key: key);

  @override
  CartePageState createState() => CartePageState();
}

class CartePageState extends State<CartePage>{

  // déplacement x et y pour chaque cercle de niveau
  static final List<List<double>> _carte = [
    // x y
    [0, 0],
    [90, -70],
    [50, -40],
    [20, -50],
    [-20, -50],
    [-50, -30],
    [-50, 30],
    [-50, 30],
    [-70, 10],
    [-50, -60],
    [20, -70],
    [40, -70],
    [20, -70],
  ];

  late Future<List<Niveau>> niveaux;

  @override
  void initState(){
    niveaux = Future<List<Niveau>>.delayed(
      const Duration(seconds: 2),
      () => SqfliteService().getNiveaux(widget.aventure.id),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aventure"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AventurePage(),
              )
            );
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpeg'),
            fit: BoxFit.fill
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15, bottom: 20),
          child: FutureBuilder<List<Niveau>>(
            future: niveaux,
            builder: (context, snapshot){
              if(snapshot.hasData){
                double translationX = 0;
                double translationY = 0;
                List<Niveau> data = snapshot.data!;
                List<Widget> children = [];

                bool complete = true;
                for(int i = 0; i < data.length; i++){
                  translationX += _carte[i][0];
                  translationY += _carte[i][1];
                  Niveau niveau = data[i];
                  
                  children.add(Transform.translate(
                    offset: Offset(translationX, translationY),
                    child: NiveauWidget(
                      aventure: widget.aventure,
                      niveau: data[i], 
                      complete: niveau.complete, 
                      niveauPrecedentComplete: complete
                    ),
                  ));

                  complete = niveau.complete;
                }
                return Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: children,
                );

              }else if(snapshot.hasError){
                return Text("${snapshot.error}");

              }else{
                return const Center(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        )
      ),
    );
  }
}
