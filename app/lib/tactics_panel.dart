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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: Text('Titulares: ${widget.matchSettings["nPlayersField"]}'),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: Text('Suplentes: ${widget.matchSettings["nPlayersBench"]}'),
              ),
            ],
          ),
          Container(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
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
                  ],
                ),
              )),
          const Expanded(child: SizedBox()),
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
          )
        ],
      ),
    );
  }
}
