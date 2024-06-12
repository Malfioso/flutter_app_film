import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/acteurs.dart';

class Acteurs extends StatelessWidget {
  const Acteurs({super.key});

  // final List<String> listeActeurs = const ["Acteur 1", "Acteur 2", "Acteur 3"];

  Future<List<Acteur>> fetchActeurs() async {
    // return ["Acteur A", "Acteur B", "Acteur C"];

    final reponse = await http.get(
        Uri.parse(
            "https://morseweiswlpykaugwtd.supabase.co/rest/v1/acteurs?select=*"),
        headers: {
          "Content-type": "application/json",
          "apikey":
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1vcnNld2Vpc3dscHlrYXVnd3RkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDY5NTcxMjgsImV4cCI6MjAyMjUzMzEyOH0.UV5XCINWe-Jaw6_-787Veh-LxjzUVudArvrgH6Ycf30"
        });

    if (reponse.statusCode == 200) {
      List<dynamic> data = json.decode(reponse.body);
      // print(reponse.body); // voir la structure des données de la réponse JSON.
      return data.map((elt) => Acteur.fromJson(elt)).toList();
    } else {
      return [Acteur(personneId: "0", nom: "ERREUR", nbFilm: 0)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acteurs"), actions: [
        Expanded(
            child: TextField(
                decoration: InputDecoration(
                  hintText: "Rechercher",
                ),
                style: TextStyle(color: Colors.white)))
      ]),
      body: FutureBuilder<List<Acteur>>(
          future: fetchActeurs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Erreur : ${snapshot.error}"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image(
                          image: NetworkImage(
                              "https://morseweiswlpykaugwtd.supabase.co/storage/v1/object/public/personnes/${snapshot.data![index].personneId}.jpg"),
                          errorBuilder: (context, error, stackstrace) {
                            return Image.asset('assets/_inconnu.jpg');
                          },
                        )),
                    title: Text(snapshot.data![index].nom),
                    subtitle: Text(snapshot.data![index].age.toString()),
                  );
                },
              );
            }
          }),
    );
  }
}
