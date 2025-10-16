import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'apps_providers/star_notifier.dart';

class Starred extends StatefulWidget {
  const Starred({super.key});

  @override
  State<Starred> createState() => _StarredState();
}

class _StarredState extends State<Starred> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StarNotifier>();
    final bookmarks = provider.bookmarks;
    return Scaffold(
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          final item = bookmarks[index];
          return ListTile(
            title: Text(item['word']),
            subtitle: Text(item['meaning']),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => provider.toggleBookmark(item['word']),
            ),
          );
        },
      ),
    );
  }
}
