import 'dart:math';
import 'package:flutter/material.dart';

/// A player's assigned info for this round.
class PlayerCard {
  final String name;
  final String role;
  final int number;

  PlayerCard({required this.name, required this.role, required this.number});
}

class GameDashboardScreen extends StatefulWidget {
  final List<String> playerNames;

  /// Customize this list for whatever game you're building
  /// (e.g. Villager/Werewolf/Detective, or Red/Blue/Spy, etc).
  final List<String> roles;

  const GameDashboardScreen({
    super.key,
    required this.playerNames,
    this.roles = const [
      'Mafia',
      'Doctor',
      'Detective',
      'Villager',
    ],
  });

  @override
  State<GameDashboardScreen> createState() => _GameDashboardScreenState();
}

class _GameDashboardScreenState extends State<GameDashboardScreen> {
  late List<PlayerCard> _players;

  @override
  void initState() {
    super.initState();
    _players = _generatePlayers();
  }

  List<PlayerCard> _generatePlayers() {
    final random = Random();
    return widget.playerNames.map((name) {
      final role = widget.roles[random.nextInt(widget.roles.length)];
      final number = random.nextInt(99) + 1; // 1 to 99
      return PlayerCard(name: name, role: role, number: number);
    }).toList();
  }

  Color _roleColor(String role) {
    // Consistent color per role based on its position in the roles list.
    final colors = [
      Colors.indigo,
      Colors.redAccent,
      Colors.teal,
      Colors.orange,
    ];
    final index = widget.roles.indexOf(role) % colors.length;
    return colors[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game dashboard'),
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _players.length,
          itemBuilder: (context, index) {
            final player = _players[index];
            final color = _roleColor(player.role);

            return Container(
              width: 100,
              height: 200,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: .circular(16),
                border: .all(color: color.withValues(alpha: 0.3)),
              ),
              padding: .all(14),
              child: Column(
                mainAxisSize: .min,
                mainAxisAlignment: .center,
                children: [
                  Text(
                    player.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: .symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: .circular(20),
                    ),
                    child: Text(
                      player.role,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: .w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Icon(Icons.tag, size: 16, color: color),
                      const SizedBox(width: 4),
                      Text(
                        '${player.number}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: .bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}