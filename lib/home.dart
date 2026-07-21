import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mafia/players_setup.dart';
import 'package:mafia/transition_animation_logic.dart';

/// The home screen of the Mafia game application.
class Home extends StatefulWidget {
  /// Creates a [Home] widget.
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double opacityLevel = 0;
  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 1), _changeOpacity);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: opacityLevel,
          duration: const Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              Image.asset(
                'assets/images/main_poster.png',
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.of(
                    context,
                  ).push(createRoute(const PlayersSetupScreen()));
                },
                child: const Text(
                  'Start Game',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
