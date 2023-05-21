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
          onPressed: () => {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text("Please enter your name"),
                content: TextFormField(),
                actions: [
                  TextButton(
                    onPressed: () => {},
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () => {},
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
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
