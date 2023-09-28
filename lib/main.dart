import 'package:flutter/material.dart';
import 'package:flutter_maps/pages/home_page.dart';
import 'package:flutter_maps/pages/map_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'homepage': (context) => const HomePage(),
        'mappage':(context) => const MapPage()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: 'homepage',
    );
  }
}
