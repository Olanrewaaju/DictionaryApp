import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DictionaryStateProvider with ChangeNotifier {
  // Keys for local storage
  static const String _historyKey = 'search_history';
  static const String _bookmarkKey = 'bookmarks';

  List<String> _searchHistory = [];
  List<String> _bookmarks = [];

  // Public getters to access the lists
  List<String> get searchHistory => _searchHistory;
  List<String> get bookmarks => _bookmarks;

  DictionaryStateProvider() {
    // Load both lists when the app starts
    _loadHistory();
    _loadBookmarks();
  }

  // --- Search History Logic ---

  void addToHistory(String word) {
    // Add to the beginning of the list & prevent duplicates
    if (_searchHistory.contains(word)) {
      _searchHistory.remove(word);
    }
    _searchHistory.insert(0, word); // Newest items first
    _saveHistory();
    notifyListeners();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    _searchHistory = prefs.getStringList(_historyKey) ?? [];
    notifyListeners();
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_historyKey, _searchHistory);
  }

  // --- Bookmark Logic ---

  bool isBookmarked(String word) {
    return _bookmarks.contains(word);
  }

  void toggleBookmark(String word) {
    if (isBookmarked(word)) {
      _bookmarks.remove(word);
    } else {
      _bookmarks.add(word);
    }
    _saveBookmarks();
    notifyListeners();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    _bookmarks = prefs.getStringList(_bookmarkKey) ?? [];
    notifyListeners();
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_bookmarkKey, _bookmarks);
  }
}
