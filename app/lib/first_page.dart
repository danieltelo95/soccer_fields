import 'package:flutter/material.dart';

class MatchSettings extends StatefulWidget {
  const MatchSettings({super.key});

  @override
  State<MatchSettings> createState() => _MatchSettingsState();
}

class _MatchSettingsState extends State<MatchSettings> {
  final Map<String, TextEditingController> controllers = {
    "Number of Players": TextEditingController(),
    "Team A": TextEditingController(),
    "Team B": TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controllers["Number of Players"],
                decoration: const InputDecoration(
                    labelText: "Number of Players",
                    hintText: "How many players?"),
              ),
              TextField(
                controller: controllers["Team A"],
                decoration: const InputDecoration(
                  labelText: "Team A",
                  hintText: "Name of team A",
                ),
              ),
              TextField(
                controller: controllers["Team B"],
                decoration: const InputDecoration(
                  labelText: "Team B",
                  hintText: "Name of team B",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
