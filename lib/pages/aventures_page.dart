import 'package:flutter/material.dart';
import 'package:mobile_tp/models/aventure_model.dart';
import 'package:mobile_tp/models/niveau_model.dart';
import 'package:mobile_tp/pages/home_page.dart';
import 'package:mobile_tp/pages/carte_page.dart';
import 'package:mobile_tp/services/sqflite_service.dart';

class AventurePage extends StatefulWidget {
  const AventurePage({Key? key}) : super(key: key);

  @override
  PageAventureState createState() => PageAventureState();
}

class PageAventureState extends State<AventurePage> {
  late Future<List<Aventure>> aventures = Future<List<Aventure>>.delayed(
    const Duration(seconds: 1),
    () => SqfliteService().getAventures(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_accueil.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: const Text('Retour'),
                ),
                const SizedBox(height: 100),
                const Text(
                  'Choisissez votre aventure',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 300,
                  child: FutureBuilder(
                    future: aventures,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else if (snapshot.hasData) {
                        final aventures = snapshot.data as List<Aventure>;
                        return ListView.builder(
                          itemCount: aventures.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder<List<Niveau>>(
                              future: SqfliteService()
                                  .getNiveaux(aventures[index].id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Erreur: ${snapshot.error}');
                                } else {
                                  final niveaux = snapshot.data!;
                                  final tousLesNiveauxCompletes = niveaux
                                      .every((niveau) => niveau.complete);
                                  final prochainNiveau = tousLesNiveauxCompletes
                                      ? null
                                      : niveaux
                                          .firstWhere(
                                              (niveau) => !niveau.complete)
                                          .palier;
                                  return Card(
                                    color: tousLesNiveauxCompletes
                                        ? Colors.green
                                        : null,
                                    child: ListTile(
                                      title: Text(aventures[index].nomJoueur),
                                      subtitle: Text(tousLesNiveauxCompletes
                                          ? 'Terminée'
                                          : 'Prochain niveau : $prochainNiveau'),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CartePage(
                                              aventure: aventures[index],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nom = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Créez une aventure'),
                content: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Nom',
                  ),
                  onSubmitted: (value) {
                    Navigator.of(context).pop(value);
                  },
                ),
              );
            },
          );

          if (nom != null) {
            await SqfliteService().addAventure(nom);
            setState(() {
              aventures = SqfliteService().getAventures();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
