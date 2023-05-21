import 'package:flutter/material.dart';
import 'package:maritech/pages/home/home_page.dart';

void main() {
  runApp(const MariTech());
}

class MariTech extends StatelessWidget {
  const MariTech({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MariTech',
      home: HomePage(),
    );
  }
}
