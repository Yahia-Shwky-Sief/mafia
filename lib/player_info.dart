import 'package:flutter/material.dart';

class PlayerInfo extends StatelessWidget {
  const PlayerInfo({required this.name, required this.role, required this.number, super.key});

  final String name;
  final String role;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Player Info Screen'),
            const SizedBox(height: 16),
            Text('Name: $name'),
            Text('Role: $role'),
            Text('Number: $number'),
          ],
        ),
      ),
    );
  }
}
