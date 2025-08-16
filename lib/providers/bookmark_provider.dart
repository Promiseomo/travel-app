import 'package:flutter/foundation.dart';

class BookmarkProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _bookmarks = [];

  List<Map<String, dynamic>> get bookmarks => _bookmarks;

  void addBookmark(Map<String, dynamic> destination) {
    if (!_bookmarks.any((item) => item['title'] == destination['title'])) {
      _bookmarks.add(destination);
      notifyListeners(); // THIS IS CRUCIAL
    }
  }

  void removeBookmark(String title) {
    _bookmarks.removeWhere((item) => item['title'] == title);
    notifyListeners();
  }

  bool isBookmarked(String destinationName) {
    return _bookmarks.any((item) => item['title'] == destinationName);
  }
}