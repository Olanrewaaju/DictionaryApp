import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'apps_providers/wordvalue.dart';

class FullDetail extends StatefulWidget {
  const FullDetail({super.key});

  @override
  State<FullDetail> createState() => _FullDetailState();
}

class _FullDetailState extends State<FullDetail> {
  @override
  Widget build(BuildContext context) {
    final searchedWord = context.read<Wordvalue>().word;

    return Scaffold(
      body: Center(child: Column(children: [Text(searchedWord)])),
    );
  }
}
