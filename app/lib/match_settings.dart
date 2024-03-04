import 'package:app/tactics_panel.dart';
import 'package:flutter/material.dart';

class MatchSettings extends StatefulWidget {
  const MatchSettings({super.key});

  @override
  State<MatchSettings> createState() => _MatchSettingsState();
}

class _MatchSettingsState extends State<MatchSettings> {
  final Map<String, TextEditingController> controllers = {
    "Team A Name": TextEditingController(),
    "Number field players": TextEditingController(),
    "Number bench players": TextEditingController(),
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
                      content:
                          const Text("Por favor completa todos los campos"),
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
                try {
                  Map<String, dynamic> matchSettings = {
                    "teamName": controllers["Team A Name"]!.text,
                    "nPlayersField":
                        int.parse(controllers["Number field players"]!.text),
                    "nPlayersBench":
                        int.parse(controllers["Number bench players"]!.text),
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TacticsPanel(matchSettings: matchSettings)),
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
            },
          )
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
                controller: controllers["Number field players"],
                decoration: const InputDecoration(
                  labelText: "Number field players",
                  hintText: "Number field players",
                ),
              ),
              TextField(
                controller: controllers["Number bench players"],
                decoration: const InputDecoration(
                  labelText: "Number bench players",
                  hintText: "Number bench players",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
