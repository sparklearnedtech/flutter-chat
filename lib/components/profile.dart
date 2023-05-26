import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:maritech/helpers/userModel.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late UserModel user;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var url = Uri.https('randomuser.me', '/api/');

    try {
      var response = await http.get(url);
      print(response.body);

      if (response.statusCode == HttpStatus.ok) {
        var jsonResponse = json.decode(response.body);
        var results = jsonResponse['results'];
        if (results != null && results.isNotEmpty) {
          var firstResult = results[0];
          setState(() {
            user = UserModel(
                fName: firstResult['name']['first'],
                lName: firstResult['name']['last'],
                email: firstResult['email'],
                isMale: firstResult['gender'] == 'male',
                picture: firstResult['picture']['large']);
            isLoading = false;
          });
        } else {
          print('No results found.');
        }
      } else {
        // Request failed
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Error occurred during the request
      print('Request failed with error: $e');
    } finally {
      // Close the HttpClient when done
      // httpClient.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          color: Colors.amber,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                // 'https://i.pinimg.com/736x/53/c8/c0/53c8c0e40d77ed6089343e55c30f08b2.jpg',
                user.picture,
                fit: BoxFit.fitWidth,
              ),
              Center(
                child: Text('${user.fName} ${user.lName}'),
              ),
              Center(
                child: Text(user.email),
              ),
            ],
          ),
        ),
      );
    }
  }
}
