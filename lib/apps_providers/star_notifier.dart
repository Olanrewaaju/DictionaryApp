import 'package:flutter/material.dart';

class StarNotifier with ChangeNotifier {
  // Store all searched words and their meanings
  final List<Map<String, dynamic>> _searchHistory = [];

  bool _isclicked = true;

  bool get isclicked => _isclicked;
  // Store bookmarked words
  final List<Map<String, dynamic>> _bookmarks = [];

  // Getter for search history
  List<Map<String, dynamic>> get searchHistory =>
      List.unmodifiable(_searchHistory);

  // Getter for bookmarks
  List<Map<String, dynamic>> get bookmarks => List.unmodifiable(_bookmarks);

  // Add a new search result (word + meaning)
  void addSearchResult(String word, dynamic meaning) {
    // Prevent duplicates; update if it already exists
    final existing = _searchHistory.indexWhere((item) => item['word'] == word);
    if (existing != -1) {
      _searchHistory[existing]['meaning'] = meaning;
    } else {
      _searchHistory.add({'word': word, 'meaning': meaning});
    }
    notifyListeners();
  }

  // Add or remove a bookmark
  void toggleBookmark(String word) {
    // Check if word already bookmarked
    final existing = _bookmarks.indexWhere((item) => item['word'] == word);

    if (existing != -1) {
      // Remove bookmark
      _bookmarks.removeAt(existing);
    } else {
      // Find it in search history
      final found = _searchHistory.firstWhere(
        (item) => item['word'] == word,
        orElse: () => <String, dynamic>{}, // ✅ Safe empty map
      );

      // Add only if found in history
      if (found.isNotEmpty) {
        _bookmarks.add(found);
      }
    }
    notifyListeners();
  }

  // Check if a word is bookmarked
  bool isBookmarked(String word) {
    _isclicked != _isclicked;
    notifyListeners();
    return _bookmarks.any((item) => item['word'] == word);
  }
}
