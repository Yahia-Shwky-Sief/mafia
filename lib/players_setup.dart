import 'package:flutter/material.dart';
import 'package:mafia/game_dashboard.dart';

class PlayersSetupScreen extends StatefulWidget {
  const PlayersSetupScreen({super.key});

  @override
  State<PlayersSetupScreen> createState() => _PlayersSetupScreenState();
}

class _PlayersSetupScreenState extends State<PlayersSetupScreen> {
  static const int _minPlayers = 6;
  static const int _maxPlayers = 20;

  int _playerCount = _minPlayers;

  // One controller per possible player slot, created up front so text
  // is preserved even if the slider goes up/down.
  final List<TextEditingController> _controllers = List.generate(
    _maxPlayers,
    (i) => TextEditingController(),
  );

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onSliderChanged(double value) {
    setState(() {
      _playerCount = value.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set up players')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Number of players',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$_playerCount',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _playerCount.toDouble(),
                    min: _minPlayers.toDouble(),
                    max: _maxPlayers.toDouble(),
                    divisions: _maxPlayers - _minPlayers,
                    label: '$_playerCount',
                    onChanged: _onSliderChanged,
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('6', style: TextStyle(color: Colors.grey)),
                      Text('20', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Divider(height: 24),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _playerCount,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TextField(
                      controller: _controllers[index],
                      decoration: InputDecoration(
                        labelText: 'Player ${index + 1} name',
                        hintText: 'Enter name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                      textCapitalization: TextCapitalization.words,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    final names = _controllers
                        .take(_playerCount)
                        .map((c) => c.text.trim())
                        .toList();
                    // Use the collected names, e.g. pass them to the next screen.
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => GameDashboardScreen(playerNames: names),
                    );
                    Navigator.push(context, route);
                  },
                  child: const Text('Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}