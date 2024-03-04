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
        title: const Text('Match Settings'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            iconSize: 32,
            onPressed: () {
              Map<String, dynamic> matchSettings = {
                "teamName": controllers["Team A Name"]!.text,
                "nPlayersField": int.parse(controllers["Number field players"]!.text),
                "nPlayersBench": int.parse(controllers["Number bench players"]!.text),
              };
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TacticsPanel(matchSettings: matchSettings)),
              );
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
                decoration: const InputDecoration(labelText: "Team Name", hintText: "What is the team name?"),
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
