import 'package:flutter/material.dart';

class FormationDropdown extends StatefulWidget {
  final String? selectedFormation;
  final Function(String?) onChanged;

  const FormationDropdown({Key? key, required this.onChanged, this.selectedFormation}) : super(key: key);

  @override
  State<FormationDropdown> createState() => _FormationDropdownState();
}

class _FormationDropdownState extends State<FormationDropdown> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Formation: ', style: TextStyle(fontSize: 16)), // Text widget before the dropdown
        const SizedBox(width: 10), // Add some spacing between the text and the dropdown
        DropdownButton<String>(
          value: widget.selectedFormation,
          hint: const Text('Choose Formation'), // Text displayed when no item is selected
          onChanged: widget.onChanged,
          items: ['4 - 4 - 2', '4 - 3 - 3', '3 - 5 - 2', '3 - 4 - 3'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class FormationDiagram extends StatefulWidget {
  final String formationString;
  final List<Map<String, dynamic>> attendees; // New line to accept attendees data

  const FormationDiagram({Key? key, required this.formationString, required this.attendees})
      : super(key: key); // Modified to accept attendees data

  @override
  State<FormationDiagram> createState() => _FormationDiagramState();
}

class _FormationDiagramState extends State<FormationDiagram> {
  List<int> _formation = [4, 4, 2]; // default formation

  @override
  void didUpdateWidget(FormationDiagram oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.formationString != widget.formationString) {
      _formation = widget.formationString.split('-').map((str) => int.tryParse(str.trim()) ?? 4).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    double playerSize = containerWidth / 20; // Adjust based on your layout preference

    return Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Goalkeeper column
          buildPlayerColumn(context, 1, playerSize),
          const Spacer(), // Adjust spacing as necessary
          // Defense columns
          buildPlayerColumn(context, _formation[0], playerSize),
          const Spacer(), // Adjust spacing as necessary
          // Midfield columns
          buildPlayerColumn(context, _formation[1], playerSize),
          const Spacer(), // Adjust spacing as necessary
          // Attack columns
          buildPlayerColumn(context, _formation[2], playerSize),
          const Spacer(), // Fill the remaining space
        ],
      ),
    );
  }

  Widget buildPlayerColumn(BuildContext context, int playerCount, double size) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          playerCount,
          (index) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    widget.attendees[index]["number"].toString(), // Display the number property
                    style: const TextStyle(color: Colors.white), // Adjust styling as needed
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
