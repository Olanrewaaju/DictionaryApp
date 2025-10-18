import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fieldfortext.dart';
import 'full_detail.dart';
import 'apps_providers/wordvalue.dart';
import 'apps_providers/star_Notifier.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchString = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    searchString.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void navigateToResult() {
    context.read<Wordvalue>().wordChanger(searchString.text);

    final query = searchString.text.trim();
    if (query.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FullDetail(navWord: query)),
      );
    }
    Provider.of<DictionaryStateProvider>(
      context,
      listen: false,
    ).addToHistory(searchString.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 90),
            Fieldfortext(
              hintText: 'Search word',
              labelText: '',
              controller: searchString,
              autoFocus: true,
              focusNode: _focusNode,
              onSubmitted: navigateToResult,
            ),
          ],
        ),
      ),
    );
  }
}
