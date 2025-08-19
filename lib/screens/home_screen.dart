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

  @override
  void initState() {
    super.initState();

    // Auto-scroll every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double current = _scrollController.offset;

        double next = current + 160; // move by one card (150 width + 10 margin)
        if (next >= maxScroll) {
          next = 0; // loop back to start
        }

        _scrollController.animateTo(
          next,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // HEADER
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
                              icon: const Icon(Icons.notifications_outlined,
                                  color: Colors.white),
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

          // BODY CONTENT
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ★ Horizontal Scrollable Destinations (Auto-scroll)
                  const SectionHeader(title: 'Today Travel Deals'),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        buildHorizontalCard(
                          "https://plus.unsplash.com/premium_photo-1697729914552-368899dc4757?q=80&w=812",
                          "Dubai",
                        ),
                        buildHorizontalCard(
                          "https://images.unsplash.com/photo-1530686577637-0ccce382b327",
                          "Miami",
                        ),
                        buildHorizontalCard(
                          "https://images.unsplash.com/photo-1693902997450-7e912c0d3554",
                          "Nairobi",
                        ),
                        buildHorizontalCard(
                          "https://images.unsplash.com/photo-1693902997450-7e912c0d3554",
                          "Nairobi",
                        ),
                        buildHorizontalCard(
                          "https://images.unsplash.com/photo-1693902997450-7e912c0d3554",
                          "Nairobi",
                        ),
                        buildHorizontalCard(
                          "https://images.unsplash.com/photo-1693902997450-7e912c0d3554",
                          "Nairobi",
                        ),
                        buildHorizontalCard(
                          "https://images.unsplash.com/photo-1693902997450-7e912c0d3554",
                          "Nairobi",
                        ),
                        buildHorizontalCard(
                          "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
                          "Maldives",
                        ),
                        buildHorizontalCard(
                          "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
                          "Paris",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Vertical Destination Cards
                  const SectionHeader(title: 'Top Destinations'),
                  const SizedBox(height: 16),
                  Column(
                    children: const [
                      DestinationCard(
                        destinationName: 'Dubai',
                        country: 'United Arab Emirates',
                        imageUrl:
                            'https://plus.unsplash.com/premium_photo-1697729914552-368899dc4757?q=80&w=812',
                        rating: 4.8,
                        price: 1200,
                      ),
                      SizedBox(height: 16),
                      DestinationCard(
                        imageUrl:
                            'https://images.unsplash.com/photo-1530686577637-0ccce382b327',
                        destinationName: 'Miami',
                        country: 'United States',
                        rating: 4.7,
                        price: 1300,
                      ),
                      SizedBox(height: 16),
                      DestinationCard(
                        imageUrl:
                            'https://images.unsplash.com/photo-1693902997450-7e912c0d3554',
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

      // Bottom Navigation
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
