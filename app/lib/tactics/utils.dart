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
