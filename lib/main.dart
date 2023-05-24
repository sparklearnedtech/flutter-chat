import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maritech/pages/home/home_page.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MariTech());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MariTech extends StatelessWidget {
  const MariTech({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MariTech',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
