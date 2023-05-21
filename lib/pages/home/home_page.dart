import 'package:flutter/material.dart';
import 'package:maritech/pages/chat/chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
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
                content: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 3) {
                      return "Please enter your name";
                    } else {
                      return null;
                    }
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () => {
                      print(nameController.text),
                      Navigator.pop(context),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(),
                        ),
                      ),
                    },
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
