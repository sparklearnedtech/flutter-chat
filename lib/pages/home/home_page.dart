import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Home Page"),
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            print('Hello World');
          },
          child: const Text(
            "Chat Page",
            style: TextStyle(
              color: Colors.amber,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
