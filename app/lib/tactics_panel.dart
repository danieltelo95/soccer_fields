import 'package:app/tactics/utils.dart';
import 'package:flutter/material.dart';

class TacticsPanel extends StatefulWidget {
  final Map<String, dynamic> matchSettings;

  const TacticsPanel({Key? key, required this.matchSettings}) : super(key: key);

  @override
  State<TacticsPanel> createState() => _TacticsPanelState();
}

class _TacticsPanelState extends State<TacticsPanel> {
  String? _selectedMatchType = '11 vs 11';
  String? _selectedFormationString = '4 - 4 - 2';

  final List<String> _matchTypes = ['11 vs 11', '9 vs 9', '7 vs 7'];

  final Map<String, List<String>> _formations = {
    '11 vs 11': ['4 - 4 - 2', '4 - 3 - 3', '3 - 5 - 2', '3 - 4 - 3'],
    '9 vs 9': ['3 - 3 - 2', '3 - 2 - 3', '4 - 2 - 2', '4 - 3 - 1'],
    '7 vs 7': ['3 - 2 - 1', '3 - 1 - 2'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.matchSettings["teamName"]} - Alineación',
          style: const TextStyle(color: Colors.white),
        ),
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
                  child: DropdownButton<String>(
                    value: _selectedMatchType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedMatchType = newValue;
                        _selectedFormationString = _formations[newValue!]![0]; // Select the first formation by default
                      });
                    },
                    items: _matchTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  DropdownButton<String>(
                    value: _selectedFormationString,
                    onChanged: (String? selectedFormation) {
                      setState(() {
                        _selectedFormationString = selectedFormation;
                      });
                    },
                    items: _formations[_selectedMatchType!]!.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
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
                    child: FormationDiagram(formationString: _selectedFormationString!),
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
