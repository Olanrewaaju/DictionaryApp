import 'package:dictionary_app/apps_providers/wordvalue.dart';
import 'package:dictionary_app/full_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'apps_providers/star_Notifier.dart';

class SavedWordsScreen extends StatelessWidget {
  final bool backButt;
  const SavedWordsScreen({super.key, this.backButt = true});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // We have two tabs: History and Bookmarks
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: backButt,
          title: const Text(
            'Bookmarks',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.history), text: 'History'),
              Tab(icon: Icon(Icons.bookmark), text: 'Bookmarks'),
            ],
          ),
        ),
        body: Consumer<DictionaryStateProvider>(
          builder: (context, provider, child) {
            return TabBarView(
              children: [
                // --- History Tab View ---
                _buildWordList(
                  context,
                  provider.searchHistory,
                  "Your search history is empty.",
                ),
                // --- Bookmarks Tab View ---
                _buildWordList(
                  context,
                  provider.bookmarks,
                  "You have no bookmarked words.",
                  isBookmarkList: true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Helper widget to build the lists to avoid code repetition
  Widget _buildWordList(
    BuildContext context,
    List<String> words,
    String emptyMessage, {
    bool isBookmarkList = false,
  }) {
    if (words.isEmpty) {
      return Center(child: Text(emptyMessage));
    }

    return ListView.builder(
      itemCount: words.length,
      itemBuilder: (context, index) {
        final word = words[index];
        return ListTile(
          title: Text(word),
          trailing: isBookmarkList
              ? IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.bookmark, color: Colors.blue),
                  onPressed: () {
                    // Toggling here will remove it
                    Provider.of<DictionaryStateProvider>(
                      context,
                      listen: false,
                    ).toggleBookmark(word);
                  },
                )
              : null, // No icon for history items
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullDetail(navWord: word),
              ),
            );
            context.read<Wordvalue>().wordChanger(word);
          },
        );
      },
    );
  }
}
