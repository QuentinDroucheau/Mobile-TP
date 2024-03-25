import 'package:flutter/material.dart';

class PageNiveaux extends StatelessWidget {
  final int totalNiveaux;
  final int niveauxCompletes;

  PageNiveaux({required this.totalNiveaux, required this.niveauxCompletes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aventure'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(totalNiveaux * 2 - 1, (index) {
              if (index % 2 == 0) {
                int niveau = totalNiveaux - index ~/ 2;
                return CircleAvatar(
                  backgroundColor: niveau <= niveauxCompletes ? Colors.green : Colors.grey,
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