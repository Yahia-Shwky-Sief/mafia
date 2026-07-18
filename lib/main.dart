import 'package:flutter/material.dart';
import 'package:mafia/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mafia Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.red,
          onPrimary: Colors.white,
          secondary: Colors.redAccent,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.grey[900]!,
          onSurface: Colors.white,
        ),
      ),
      home: Home(),
    );
  }
}
