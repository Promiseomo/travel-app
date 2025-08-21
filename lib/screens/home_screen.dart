import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travel_newest/screens/destinations/bookmarks_screen.dart';
import 'package:travel_newest/widget.dart/destination_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;

  final TextEditingController _searchController = TextEditingController();
  String query = "";

  final List<Map<String, dynamic>> _destinations = [
    {
      "destinationName": "Dubai",
      "country": "United Arab Emirates",
      "imageUrl":
          "https://plus.unsplash.com/premium_photo-1697729914552-368899dc4757?q=80&w=812",
      "rating": 4.8,
      "price": 1200
    },
    {
      "destinationName": "Miami",
      "country": "United States",
      "imageUrl": "https://images.unsplash.com/photo-1530686577637-0ccce382b327",
      "rating": 4.7,
      "price": 1300
    },
    {
      "destinationName": "Nairobi",
      "country": "Kenya",
      "imageUrl": "https://images.unsplash.com/photo-1693902997450-7e912c0d3554",
      "rating": 4.6,
      "price": 1100
    },
    {
      "destinationName": "Paris",
      "country": "France",
      "imageUrl": "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
      "rating": 4.9,
      "price": 1500
    },
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double current = _scrollController.offset;

        double next = current + 160;
        if (next >= maxScroll) {
          next = 0;
        }

        _scrollController.animateTo(
          next,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });

    _searchController.addListener(() {
      setState(() {
        query = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredDestinations = _destinations
        .where((d) =>
            d["destinationName"].toLowerCase().contains(query) ||
            d["country"].toLowerCase().contains(query))
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      
      // ✅ EXPLICITLY SET DRAWER TO NULL TO PREVENT DEFAULT
      drawer: null,
      
      // ✅ ONLY THE SCROLLABLE WHITE DRAWER
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Promise Omoregie"),
              accountEmail: Text("flutterdev@email.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=3",
                ),
              ),
              decoration: BoxDecoration(color: Color(0xFF3366FF)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text("Bookmarks"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BookmarksScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {},
            ),
          ],
        ),
      ),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            automaticallyImplyLeading: false, // No back button
            // ✅ EXPLICITLY SET LEADING TO NULL
            leading: null,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
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
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: 'Search destinations...',
                              border: InputBorder.none,
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.blue),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 15),
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

          // BODY CONTENT
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (query.isNotEmpty && filteredDestinations.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "No results found",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  else ...[
                    const SectionHeader(title: 'Today Travel Deals'),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: ListView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: _destinations.map((d) {
                          return buildHorizontalCard(
                            d["imageUrl"],
                            d["destinationName"],
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const SectionHeader(title: 'Explore Destinations'),
                    const SizedBox(height: 16),
                    Column(
                      children: filteredDestinations.map((d) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: DestinationCard(
                            imageUrl: d["imageUrl"],
                            destinationName: d["destinationName"],
                            country: d["country"],
                            rating: d["rating"],
                            price: d["price"],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget for horizontal image cards
Widget buildHorizontalCard(String imageUrl, String title) {
  return Container(
    width: 150,
    margin: const EdgeInsets.only(right: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      image: DecorationImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover,
      ),
    ),
    alignment: Alignment.bottomLeft,
    padding: const EdgeInsets.all(12),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        shadows: [Shadow(blurRadius: 6, color: Colors.black54)],
      ),
    ),
  );
}

// Reusable SectionHeader widget
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