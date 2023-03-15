import 'package:flutter/material.dart';
import 'package:the_juice/catalog_page.dart';
import 'package:the_juice/juice_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/catalog_page': (context) => const CatalogPage(),
        '/juice_page': (context) => const JuicePage(),
      },
      initialRoute: '/catalog_page',
      home: const Scaffold(),
    );
  }
}