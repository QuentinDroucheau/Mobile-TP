import 'package:flutter/material.dart';
import 'package:mobile_tp/models/Niveau.dart';

class PageNiveaux extends StatefulWidget {
  final int totalNiveaux;
  final int idAventure;
  final List<Niveau> niveauxCompletesListe = [];

  PageNiveaux({required this.totalNiveaux, required this.idAventure});

  @override
  _PageNiveauxState createState() => _PageNiveauxState();
}

class _PageNiveauxState extends State<PageNiveaux> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aventure'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(widget.totalNiveaux * 2 - 1, (index) {
              if (index % 2 == 0) {
                int niveau = widget.totalNiveaux - index ~/ 2;
                return CircleAvatar(
                  backgroundColor: niveau <= widget.niveauxCompletesListe.length
                      ? Colors.green
                      : Colors.grey,
                  child: Text(niveau.toString()),
                );
              } else {
                return SizedBox(
                  height: 20,
                  child: VerticalDivider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
