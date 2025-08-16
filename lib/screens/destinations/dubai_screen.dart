import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/bookmark_provider.dart';

class DubaiScreen extends StatelessWidget {
  const DubaiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final isBookmarked = bookmarkProvider.isBookmarked('Dubai');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dubai, UAE'),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? Colors.amber : Colors.white,
            ),
            onPressed: () {
              final destination = {
                'title': 'Dubai',
                'description': 'United Arab Emirates',
                'imageUrl': 'https://plus.unsplash.com/premium_photo-1697729914552-368899dc4757',
              };
              
              if (isBookmarked) {
                bookmarkProvider.removeBookmark('Dubai');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Removed from bookmarks'),
                    duration: Duration(seconds: 1),
                  ),
                );
              } else {
                bookmarkProvider.addBookmark(destination);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Added to bookmarks!'),
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Dubai Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://plus.unsplash.com/premium_photo-1697729914552-368899dc4757',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Dubai description
            const Text(
              'Dubai is a city of superlatives with the world\'s tallest building, '
              'largest shopping mall, and luxurious hotels blending modern architecture '
              'with Arabian culture.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            
            const SizedBox(height: 20),
            
            // Dubai sections
            _buildSection('Architectural Marvels', [
              'Burj Khalifa - World\'s tallest building at 828m',
              'Palm Jumeirah - Iconic palm-shaped island',
              'Dubai Frame - Stunning golden picture frame'
            ]),
            
            _buildSection('Desert Adventures', [
              'Dune bashing - Thrilling 4x4 desert rides',
              'Camel trekking - Traditional Bedouin experience',
              'Hot air balloon - Sunrise over the dunes'
            ]),
            
            const SizedBox(height: 30),
            
            // Book Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking for Dubai confirmed!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800], // Dubai blue
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'BOOK NOW',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Identical section builder to MiamiScreen (just with blue icons)
  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              const Icon(Icons.arrow_right, color: Colors.blue),
              const SizedBox(width: 8),
              Text(item),
            ],
          ),
        )),
        const SizedBox(height: 16),
      ],
    );
  }
}