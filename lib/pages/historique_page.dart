import 'package:flutter/material.dart';
import 'package:mobile_tp/models/partie_model.dart';
import 'package:mobile_tp/services/sqflite_service.dart';
import 'package:mobile_tp/widgets/partie_widget.dart';

class HistoriquePage extends StatefulWidget{

  const HistoriquePage({Key? key}) : super(key: key);
  
  @override
  HistoriquePageState createState() => HistoriquePageState();
}

class HistoriquePageState extends State<HistoriquePage>{

  final Future<List<Partie>> parties = Future<List<Partie>>.delayed(
    const Duration(seconds: 2),
    () => SqfliteService().getHistorique(),
  );

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique'),
      ),
      body: Container(
        child: FutureBuilder<List<Partie>>(
          future: parties,
          builder: (context, snapshot){
            if(snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  return HistoriqueWidget(partie: snapshot.data![index]);
                },
              );
            }else if (snapshot.hasError){
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