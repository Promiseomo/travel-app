import 'package:flutter/material.dart';
import 'package:travel_newest/screens/destinations/bookmarks_screen.dart';
import 'package:travel_newest/widget.dart/destination_card.dart';
import 'package:travel_newest/widget.dart/section_header.dart';
import 'package:travel_newest/widgets.dart/destination_card.dart';
import 'package:travel_newest/widgets.dart/travel_category.dart';
import 'screens/destinations/dubai_screen.dart';
import 'screens/destinations/miami_screen.dart';
import 'screens/destinations/nairobi_screen.dart';
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF3366FF), Color(0xFF00CCFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://cdn-icons-png.flaticon.com/512/201/201623.png',
                              ),
                              radius: 20,
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Where would you\nlike to explore today?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: 'Search destinations...',
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search, color: Colors.blue),
                              contentPadding: EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Travel Categories Section
                  const SectionHeader(title: 'Travel Categories'),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        TravelCategory(
                          icon: Icons.beach_access,
                          label: 'Beaches',
                          color: Colors.blue,
                        ),
                        SizedBox(width: 16),
                        TravelCategory(
                          icon: Icons.landscape,
                          label: 'Mountains',
                          color: Colors.green,
                        ),
                        SizedBox(width: 16),
                        TravelCategory(
                          icon: Icons.account_balance,
                          label: 'Cities',
                          color: Colors.orange,
                        ),
                        SizedBox(width: 16),
                        TravelCategory(
                          icon: Icons.forest,
                          label: 'Forests',
                          color: Colors.brown,
                        ),
                        SizedBox(width: 16),
                        TravelCategory(
                          icon: Icons.directions_boat,
                          label: 'Islands',
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Top Destinations Section
                  const SectionHeader(title: 'Top Destinations'),
                  const SizedBox(height: 16),
                  Column(
                    children: const [
                      DestinationCard(
                         destinationName: 'Dubai',
                          country: 'United Arab Emirates',
                      imageUrl: 'https://plus.unsplash.com/premium_photo-1697729914552-368899dc4757?q=80&w=812',

                        rating: 4.8,
                        price: 1200,
                      ),
                      SizedBox(height: 16),
                      DestinationCard(
                        imageUrl: 'https://images.unsplash.com/photo-1530686577637-0ccce382b327',
                       destinationName: 'Miami',
                        country: 'United States',
                        rating: 4.7,
                        price: 1300,
                      ),
                      SizedBox(height: 16),
                      DestinationCard(
                        imageUrl: 'https://images.unsplash.com/photo-1693902997450-7e912c0d3554',
                        destinationName: 'Nairobi',
                        country: 'Kenya',
                        rating: 4.6,
                        price: 1100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      
      
      // In your HomeScreen class
bottomNavigationBar: BottomAppBar(
  height: 70,
  padding: EdgeInsets.zero,
  shape: const CircularNotchedRectangle(),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      IconButton(
        icon: const Icon(Icons.home, size: 28),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
        color: const Color(0xFF3366FF),
      ),
      IconButton(
        icon: const Icon(Icons.bookmark, size: 28),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BookmarksScreen()),
          );
        },
        color: Colors.grey,
      ),
      IconButton(
        icon: const Icon(Icons.person_outline, size: 28),
        onPressed: () {},
        color: Colors.grey,
      ),
    ],
  ),
),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}