import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_tp/models/Aventure.dart';
import 'package:mobile_tp/models/Niveau.dart';
import 'dart:math';

import 'package:mobile_tp/models/Partie.dart';
import 'package:mobile_tp/services/SqliteService.dart';
import 'package:mobile_tp/widgets/niveau_widget.dart';

class CarteWidget extends StatefulWidget{

  final Aventure aventure;

  const CarteWidget({
    super.key,
    required this.aventure
  });

  @override
  _CarteWidget createState() => _CarteWidget();
}

class _CarteWidget extends State<CarteWidget>{
  // -> x 
  // |  -y

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

  @override
  Widget build(BuildContext context){
    final Future<List<Niveau>> niveaux = Future<List<Niveau>>.delayed(
      const Duration(seconds: 2),
      () => SqliteService().getNiveaux(widget.aventure.id),
    );

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpeg'),
          fit: BoxFit.fill
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15, bottom: 20),
        child: FutureBuilder<List<Niveau>>(
          future: niveaux,
          builder: (context, snapshot){
            if(snapshot.hasData){
              double translation_x = 0;
              double translation_y = 0;
              List<Niveau> data = snapshot.data!;
              List<Widget> children = [];

              bool complete = true;
              for(int i = 0; i < data.length; i++){
                translation_x += _carte[i][0];
                translation_y += _carte[i][1];
                Niveau niveau = data[i];
                
                children.add(Transform.translate(
                  offset: Offset(translation_x, translation_y),
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
    );
  }
}