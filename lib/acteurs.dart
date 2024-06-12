import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Acteurs extends StatelessWidget {
  const Acteurs({super.key});

  final List<String> listeActeurs = const ["Acteur 1", "Acteur 2", "Acteur 3"];

  Future<List<String>> fetchActeurs() async {
    //return ["Acteur A", "Acteur B", "Acteur C"];

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
      print(reponse.body);
      return data.map((elt) => elt["nom"].toString()).toList();
    } else {
      return ["ERREUR API"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acteurs")),
      body: FutureBuilder<List<String>>(
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
                  return ListTile(title: Text(snapshot.data![index]));
                },
              );
            }
          }),
    );
  }
}