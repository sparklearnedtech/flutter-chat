import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:maritech/helpers/userModel.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserModel? user;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var url = Uri.parse(
        'http://randomuser.me/api/'); // Replace with your API endpoint

    // Create an HttpClient instance
    var httpClient = HttpClient();

    // Ignore SSL certificate checks
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    try {
      var request = await httpClient.getUrl(url);
      var response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        // Request successful, parse the response
        var data = await response.transform(utf8.decoder).join();
        // Request successful, parse the response
        var jsonResponse = json.decode(data);
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
      httpClient.close();
    }
  }

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: const Center(
        child: Text('Profile Component'),
      ),
    );
  }
}
