import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mafia/player_info.dart';

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
    required this.playerNames, super.key,
    this.roles = const ['Mafia', 'Doctor', 'Detective', 'Villager'],
  });

  @override
  State<GameDashboardScreen> createState() => _GameDashboardScreenState();
}

class _GameDashboardScreenState extends State<GameDashboardScreen> {
  late List<PlayerCard> _players;
  late int numberOfMafia;
  late int numberOfDoctors;
  late int numberOfDetectives;

  @override
  void initState() {
    super.initState();
    _players = _generatePlayers();
  }

  List<PlayerCard> _generatePlayers() {
    final random = Random();

    if (widget.playerNames.length == 6) {
      numberOfMafia = 1;
      numberOfDoctors = 1;
      numberOfDetectives = 1;
    } else if (widget.playerNames.length >= 7 &&
        widget.playerNames.length <= 10) {
      numberOfMafia = 2;
      numberOfDoctors = 1;
      numberOfDetectives = 1;
    } else if (widget.playerNames.length >= 11 &&
        widget.playerNames.length <= 15) {
      numberOfMafia = 4;
      numberOfDoctors = 1;
      numberOfDetectives = 2;
    } else {
      numberOfMafia = 5;
      numberOfDoctors = 2;
      numberOfDetectives = 2;
    }
    return widget.playerNames.map((name) {
      /// randomly assign roles based on the number of each role left to assign and assign random number from 1 to 99

      return PlayerCard(
        name: name,
        role: _assignRole(),
        number: random.nextInt(99) + 1,
      );
    }).toList();
  }

  String _assignRole() {
    var assignedRole = '';
    while (assignedRole == '') {
      final random = Random().nextInt(widget.roles.length);
      final role = widget.roles[random];

      if (role == 'Mafia' && numberOfMafia > 0) {
        assignedRole = 'Mafia';
        numberOfMafia--;
      } else if (role == 'Doctor' && numberOfDoctors > 0) {
        assignedRole = 'Doctor';
        numberOfDoctors--;
      } else if (role == 'Detective' && numberOfDetectives > 0) {
        assignedRole = 'Detective';
        numberOfDetectives--;
      } else if (role == 'Villager') {
        assignedRole = 'Villager';
      }
    }
    return assignedRole;
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
      appBar: AppBar(title: const Text('Game dashboard')),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 140,
          ),
          itemCount: _players.length,
          itemBuilder: (context, index) {
            final player = _players[index];
            final color = _roleColor(player.role);

            return MaterialButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => PlayerInfo(
                      name: player.name,
                      role: player.role,
                      number: player.number,
                    ),
                  ),
                );
              },
              minWidth: 100,
              color: color.withValues(alpha: 0.08),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: color.withValues(alpha: 0.3)),
              ),
              padding: const .all(14),
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
                    padding: const .symmetric(horizontal: 10, vertical: 4),
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
