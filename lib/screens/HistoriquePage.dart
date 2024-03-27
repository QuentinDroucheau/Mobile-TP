import 'package:flutter/material.dart';
import 'package:mobile_tp/models/Partie.dart';
import 'package:mobile_tp/services/SqliteService.dart';
import 'package:mobile_tp/widgets/partie_widget.dart';

class HistoriquePage extends StatefulWidget{
  
  @override
  _HistoriquePageState createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage>{

  final Future<List<Partie>> parties = Future<List<Partie>>.delayed(
    const Duration(seconds: 2),
    () => SqliteService().getHistorique(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique'),
      ),
      body: Container(
        child: FutureBuilder<List<Partie>>(
          future: parties,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return PartieWidget(partie: snapshot.data![index]);
                },
              );
            }else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}