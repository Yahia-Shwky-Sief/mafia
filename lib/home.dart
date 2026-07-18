import 'package:flutter/material.dart';
import 'package:mafia/players_setup.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Image.asset(
                'assets/images/main_poster.png',
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
              ElevatedButton(
                onPressed: () {
                 MaterialPageRoute route = MaterialPageRoute(
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
