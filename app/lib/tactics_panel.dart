import 'package:app/tactics/utils.dart';
import 'package:flutter/material.dart';

class TacticsPanel extends StatefulWidget {
  final Map<String, dynamic> matchSettings;

  const TacticsPanel({super.key, required this.matchSettings});

  @override
  State<TacticsPanel> createState() => _TacticsPanelState();
}

class _TacticsPanelState extends State<TacticsPanel> {
  String? _formationString = '4 - 4 - 2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.matchSettings["teamName"]} - Alineación', style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Text('Jugadores: ${widget.matchSettings["nPlayers"]}'),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  FormationDropdown(
                    selectedFormation: _formationString,
                    onChanged: (String? selectedFormation) {
                      print("Selected formation: $selectedFormation");
                      setState(() {
                        _formationString = selectedFormation;
                      });
                    },
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      image: const DecorationImage(
                        image: AssetImage("assets/backgrounds/football_field_v1.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: FormationDiagram(formationString: _formationString ?? '4-4-2'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Jugadores",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: buildPlayerColumn(0)),
                const SizedBox(width: 16),
                Expanded(child: buildPlayerColumn((widget.matchSettings['nPlayers'] / 2).ceil())),
              ],
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  print("Guardar");
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text(
                  "Guardar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlayerColumn(int startIndex) {
    return Column(
      children: List.generate(
        (widget.matchSettings['nPlayers'] / 2).ceil(),
        (index) => buildPlayerRow(startIndex + index),
      ),
    );
  }

  Widget buildPlayerRow(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          index < widget.matchSettings["Attendees"]!.length
              ? widget.matchSettings["Attendees"][index]["username"]
              : "Cupo disponible",
        ),
      ],
    );
  }
}
