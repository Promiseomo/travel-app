// lib/screens/destinations/bookmarks_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/bookmark_provider.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarks = context.watch<BookmarkProvider>().bookmarks;
    debugPrint('Bookmarks Screen: Displaying ${bookmarks.length} bookmarks'); // Debug

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookmarks'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: bookmarks.isEmpty
          ? _buildEmptyState(context)
          : RefreshIndicator(
              onRefresh: () async {
                // Force rebuild
                context.read<BookmarkProvider>().notifyListeners();
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: bookmarks.length,
                separatorBuilder: (context, index) => const Divider(height: 16),
                itemBuilder: (context, index) {
                  final destination = bookmarks[index];
                  debugPrint('Displaying bookmark: ${destination['title']}'); // Debug
                  
                  return Dismissible(
                    key: Key(destination['title']),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) {
                      context.read<BookmarkProvider>().removeBookmark(destination['title']);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Removed ${destination['title']}'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: Hero(
                          tag: 'bookmark-${destination['title']}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              destination['imageUrl'] ?? '',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => 
                                const Icon(Icons.image, size: 60),
                            ),
                          ),
                        ),
                        title: Text(
                          destination['title'] ?? 'Unknown Destination',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(destination['country'] ?? ''),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 16),
                                Text(' ${destination['rating'] ?? '0.0'}'),
                                const Spacer(),
                                Text(
                                  '\$${destination['price']?.toString() ?? '0'}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<BookmarkProvider>().removeBookmark(destination['title']);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Removed ${destination['title']}'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.bookmark_border,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'No bookmarks yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap the bookmark icon on destinations to save them here',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Return to previous screen
            },
            child: const Text('Explore Destinations'),
          ),
        ],
      ),
    );
  }
}