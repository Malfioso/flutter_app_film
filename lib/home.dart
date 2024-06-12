import 'package:flutter/material.dart';
import 'package:flutter_application_1/acteurs.dart';
import 'home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF663399),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Center(
            child: Text(
          'Cinéma',
          style: TextStyle(color: Colors.white, fontSize: 30),
        )),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
            onPressed: () {
              print("J'ai appuyé sur 1");
            },
            icon: const Icon(Icons.home, size: 50, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Acteurs()));
              print("J'ai appuyé sur 2");
            },
            icon: const Icon(Icons.theater_comedy,
                size: 50, color: Color.fromARGB(255, 209, 44, 44)),
          ),
          IconButton(
              onPressed: () {
                print("J'ai appuyé sur 3");
              },
              icon: const Icon(Icons.airplane_ticket,
                  size: 50, color: Colors.white)),
        ])
      ]),
    );
  }
}
