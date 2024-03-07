import 'package:flutter/material.dart';

class FormationDropdown extends StatefulWidget {
  final String? selectedFormation;
  final Function(String?) onChanged;

  const FormationDropdown({super.key, required this.onChanged, this.selectedFormation});

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

  const FormationDiagram({Key? key, required this.formationString}) : super(key: key);

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
          Spacer(), // Adjust spacing as necessary
          // Defense columns
          buildPlayerColumn(context, _formation[0], playerSize),
          Spacer(), // Adjust spacing as necessary
          // Midfield columns
          buildPlayerColumn(context, _formation[1], playerSize),
          Spacer(), // Adjust spacing as necessary
          // Attack columns
          buildPlayerColumn(context, _formation[2], playerSize),
          Spacer(), // Fill the remaining space
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
          (index) => Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.shade800,
            ),
          ),
        ),
      ),
    );
  }
}
