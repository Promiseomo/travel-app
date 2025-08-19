import 'package:flutter/material.dart';
import 'package:travel_newest/screens/home_screen.dart';


import 'package:provider/provider.dart';
import 'providers/bookmark_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BookmarkProvider(),
      child: const TravelApp(),
    ),
  );
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wanderlust',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const HomeScreen(),
    );
  }
}

