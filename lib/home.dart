import 'package:flutter/material.dart';
import 'package:mafia/players_setup.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'assets/images/main_poster.png',
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
              ElevatedButton(
                onPressed: () {
                 var route = MaterialPageRoute(
                    builder: (context) => const PlayersSetupScreen(),
                  );
                  Navigator.push(context, route);
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
