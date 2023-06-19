import 'package:flutter/material.dart';

void main() {
  runApp(const SekrutApp());
}

class SekrutApp extends StatelessWidget {
  const SekrutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Text("Sekrut"),
          ),
        ),
      ),
    );
  }
}
