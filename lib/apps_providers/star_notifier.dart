import 'package:flutter/material.dart';

class StarNotifier with ChangeNotifier {
  // Store bookmarked words and their meanings
  final List<Map<String, String>> _bookMarkedWords = [];

  List<Map<String, String>> get bookMarkedWords => _bookMarkedWords;

  /// Toggle a word's bookmark status
  void toggleBookmark(String word, String meaning) {
    final existingIndex = _bookMarkedWords.indexWhere(
      (item) => item['word'] == word,
    );

    if (existingIndex >= 0) {
      // Word already bookmarked → remove it
      _bookMarkedWords.removeAt(existingIndex);
    } else {
      // New word → add to bookmarks
      _bookMarkedWords.add({'word': word, 'meaning': meaning});
    }

    notifyListeners();
  }

  bool isBookmarked(String word) {
    return _bookMarkedWords.any((item) => item['word'] == word);
  }

  /// Optional: clear all bookmarks
  void clearBookmarks() {
    _bookMarkedWords.clear();
    notifyListeners();
  }
}
