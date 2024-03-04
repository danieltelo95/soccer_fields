import 'package:flutter/material.dart';

class TacticsPanel extends StatefulWidget {
  final Map<String, dynamic> matchSettings;

  const TacticsPanel({super.key, required this.matchSettings});

  @override
  State<TacticsPanel> createState() => _TacticsPanelState();
}

class _TacticsPanelState extends State<TacticsPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Row(
          children: [
            Text('Team name: ${widget.matchSettings["teamName"]}'),
            const SizedBox(width: 10),
            Text('Players Field: ${widget.matchSettings["nPlayersField"]}'),
            const SizedBox(width: 10),
            Text('Subs: ${widget.matchSettings["nPlayersBench"]}'),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
