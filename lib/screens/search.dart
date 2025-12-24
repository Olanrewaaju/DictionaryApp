import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/fieldfortext.dart';
import 'full_detail.dart';
import '../state_management/wordvalue.dart';
import 'package:dictionary_app/state_management/star_notifier.dart';

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
    print(_focusNode.hasFocus);
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // const SizedBox(height: 90),
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
