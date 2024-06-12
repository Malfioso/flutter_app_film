import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/acteurs.dart';

class Acteurs extends StatefulWidget {
  @override
  ActeursState createState() => ActeursState();
}

class ActeursState extends State<Acteurs> {
  // final List<String> listeActeurs = const ["Acteur 1", "Acteur 2", "Acteur 3"];

  TextEditingController _textController = TextEditingController();

  List<Acteur> listeComplete = [];
  List<Acteur> listeFiltree = [];

  @override
  void initState() {
    super.initState();
    fetchActeurs();
    _textController.addListener(rechercheActeur);
  }

  void rechercheActeur() {
    String achercher = _textController.text.toLowerCase();
    print(achercher);
    setState(() {
      listeFiltree = listeComplete
          .where((acteur) =>
              acteur.nom.toLowerCase().contains(achercher))
          .toList();
    });
  }

  Future<void> fetchActeurs() async {
    // return ["Acteur A", "Acteur B", "Acteur C"];

    print("Appel API !");

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
      listeComplete = data.map((acteur) => Acteur.fromJson(acteur)).toList();
      listeFiltree = listeComplete;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Expanded(child: Text("Acteurs")),
            Expanded(
                child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: "Rechercher",
                      hintStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white)))
          ]),
        ),
        body: ListView.builder(
          itemCount: listeFiltree.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image(
                    image: NetworkImage(
                        "https://morseweiswlpykaugwtd.supabase.co/storage/v1/object/public/personnes/${listeFiltree[index].personneId}.jpg"),
                    errorBuilder: (context, error, stackstrace) {
                      return Image.asset('assets/_inconnu.jpg');
                    },
                  )),
              title: Text(listeFiltree[index].nom),
              subtitle: Text(listeFiltree[index].age.toString()),
            );
          },
        ));
  }
}
