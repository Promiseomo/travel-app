// lib/widgets/destination_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_newest/providers/bookmark_provider.dart';
import 'package:travel_newest/screens/destinations/dubai_screen.dart';
import 'package:travel_newest/screens/destinations/miami_screen.dart';
import 'package:travel_newest/screens/destinations/nairobi_screen.dart';

class DestinationCard extends StatelessWidget {
  final String destinationName;
  final String country;
  final String imageUrl;
  final double rating;
  final int price;

  const DestinationCard({
    super.key,
    required this.destinationName,
    required this.country,
    required this.imageUrl,
    required this.rating,
    required this.price,
  });

  void _navigateToDetail(BuildContext context) {
    switch (destinationName.toLowerCase()) {
      case 'dubai':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const DubaiScreen()));
        break;
      case 'miami':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const MiamiScreen()));
        break;
      case 'nairobi':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const NairobiScreen()));
        break;
      default:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const DubaiScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarkProvider>(
      builder: (context, bookmarkProvider, child) {
        final isBookmarked = bookmarkProvider.isBookmarked(destinationName);

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _navigateToDetail(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        imageUrl,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey[200],
                          height: 150,
                          child: const Icon(Icons.image, size: 50),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_add,
                          color: isBookmarked ? Colors.blue : Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          final destination = {
                            'title': destinationName,
                            'country': country,
                            'imageUrl': imageUrl,
                            'price': price,
                            'rating': rating,
                          };
                          
                          if (isBookmarked) {
                            bookmarkProvider.removeBookmark(destinationName);
                          } else {
                            bookmarkProvider.addBookmark(destination);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$destinationName added to bookmarks!'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destinationName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        country,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(' $rating'),
                          const Spacer(),
                          Text(
                            '\$$price',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}