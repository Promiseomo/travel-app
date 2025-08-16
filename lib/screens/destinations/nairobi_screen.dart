import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/bookmark_provider.dart';

class NairobiScreen extends StatelessWidget {
  const NairobiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);
    final isBookmarked = bookmarkProvider.isBookmarked('Nairobi');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nairobi, Kenya'),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? Colors.amber : Colors.white,
            ),
            onPressed: () {
              final destination = {
                'title': 'Nairobi',
                'description': 'Kenya',
                'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/7/70/Nairobi_skyline.jpg',
              };
              
              if (isBookmarked) {
                bookmarkProvider.removeBookmark('Nairobi');
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
            // Nairobi Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://images.unsplash.com/photo-1693902997450-7e912c0d3554',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.image, size: 100, color: Colors.grey),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Nairobi description
            const Text(
              'Nairobi blends urban energy with wild nature, offering a unique mix '
              'of skyscrapers, national parks, and rich cultural heritage.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            
            const SizedBox(height: 20),
            
            // Nairobi sections
            _buildSection('Wildlife Experiences', [
              'Nairobi National Park - Safari with city skyline views',
              'Giraffe Centre - Feed endangered Rothschild giraffes',
              'David Sheldrick Trust - Elephant orphanage visit'
            ]),
            
            _buildSection('Cultural Highlights', [
              'Karen Blixen Museum - "Out of Africa" history',
              'Maasai Market - Authentic crafts and souvenirs',
              'Bomas of Kenya - Traditional village experience'
            ]),
            
            const SizedBox(height: 30),
            
            // Book Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking for Nairobi confirmed!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[800], // Nairobi sunset color
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

  // Consistent section builder with orange icons
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
              const Icon(Icons.arrow_right, color: Colors.orange),
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