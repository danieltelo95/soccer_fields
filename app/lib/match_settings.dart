import 'package:app/tactics_panel.dart';
import 'package:flutter/material.dart';

class MatchSettings extends StatefulWidget {
  const MatchSettings({super.key});

  @override
  State<MatchSettings> createState() => _MatchSettingsState();
}

class _MatchSettingsState extends State<MatchSettings> {
  final Map<String, dynamic> controllers = {
    "Team A Name": TextEditingController(),
    "Number of players": TextEditingController(),
    "Attendees": <Map<String, dynamic>>[
      {"username": 'Kahn', "number": 1},
      {"username": 'Cafu', "number": 2},
      {"username": 'Puyol', "number": 3},
      {"username": 'Ramos', "number": 13},
      {"username": 'Zanetti', "number": 4},
      {"username": 'Zidane', "number": 5},
      {"username": 'Maradona', "number": 8},
      {"username": 'Dinho', "number": 10},
      {"username": 'Messi', "number": 19},
      {"username": 'C. Ronaldo', "number": 7},
      {"username": 'Ronaldo', "number": 9}
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Match Settings',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                if (controllers["Team A Name"]!.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Faltan datos"),
                        content: const Text("Por favor completa todos los campos"),
                        actions: <Widget>[
                          TextButton(
                              child: const Text("Ok"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              })
                        ],
                      );
                    },
                  );
                } else {
                  if (controllers["Number of players"]!.text.isEmpty ||
                      int.parse(controllers["Number of players"]!.text) < 12 ||
                      int.parse(controllers["Number of players"]!.text) > 40) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Número de jugadores incorrecto"),
                          content: const Text("El número de jugadores debe estar entre 6 y 40"),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("Ok"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      },
                    );
                  } else {
                    try {
                      Map<String, dynamic> matchSettings = {
                        "teamName": controllers["Team A Name"]!.text,
                        "Attendees": controllers["Attendees"],
                        "nPlayers": int.parse(controllers["Number of players"]!.text),
                      };
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TacticsPanel(matchSettings: matchSettings)),
                      );
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Datos incorrectos"),
                            content: const Text("Deben ser números"),
                            actions: <Widget>[
                              TextButton(
                                  child: const Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  })
                            ],
                          );
                        },
                      );
                    }
                  }
                }
              })
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controllers["Team A Name"],
                decoration: const InputDecoration(
                  labelText: "Team Name",
                  hintText: "What is the team name?",
                ),
              ),
              TextField(
                controller: controllers["Number of players"],
                decoration: const InputDecoration(
                  labelText: "Number of players",
                  hintText: "Between 12 and 40",
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  for (var attendee in controllers["Attendees"]!) Text(attendee["username"]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
