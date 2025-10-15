import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'apps_providers/wordvalue.dart';
import 'package:http/http.dart' as http;

class FullDetail extends StatefulWidget {
  const FullDetail({super.key});

  @override
  State<FullDetail> createState() => _FullDetailState();
}

class _FullDetailState extends State<FullDetail> {
  late Future _value;
  late String searchedWord;

  @override
  void initState() {
    super.initState();
    searchedWord = '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        searchedWord = context.read<Wordvalue>().word;
        _value = fetchWordDetails();
      });
    });
  }

  Future fetchWordDetails() async {
    final searchedWord = context.read<Wordvalue>().word;
    final url = Uri.parse(
      'https://www.dictionaryapi.com/api/v3/references/collegiate/json/$searchedWord?key=2afc2bda-51f6-4b3c-b99a-a5997a238778',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        throw Exception("Invalid JSON format");
      }
    } else {
      throw Exception('Error fetching word details');
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchedWord = context.read<Wordvalue>().word;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.star, size: 26, color: Colors.grey),
            SizedBox(width: 30),
            Icon(Icons.reply, size: 26, color: Colors.grey),
            SizedBox(width: 30),
            Icon(Icons.more_horiz, size: 26, color: Colors.grey),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: _value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("No data found"));
            }

            final wordData = snapshot.data;
            if (wordData == null || wordData.isEmpty) {
              return const Center(child: Text("No data found"));
            }

            // Handle cases where the API returns string suggestions instead of word objects
            if (wordData is List &&
                wordData.isNotEmpty &&
                wordData[0] is String) {
              return Center(
                child: Text(
                  "Did you mean: ${wordData.take(5).join(', ')}?",
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }

            final first = wordData[0];
            final word =
                first['hwi']?['hw']?.replaceAll('*', '') ?? searchedWord;
            final pronunciation = first['hwi']?['prs']?[0]?['mw'] ?? '—';
            final partOfSpeech = first['fl'] ?? '—';
            final definitions = <String>[];
            final examples = <String>[];

            // Safely extract definitions and examples
            if (first['def'] != null && first['def'] is List) {
              for (var def in first['def']) {
                if (def['sseq'] != null && def['sseq'] is List) {
                  for (var sseq in def['sseq']) {
                    if (sseq is List) {
                      for (var sensePair in sseq) {
                        if (sensePair is List &&
                            sensePair.length > 1 &&
                            sensePair[1] is Map &&
                            sensePair[1]['dt'] != null) {
                          for (var dt in sensePair[1]['dt']) {
                            try {
                              if (dt[0] == 'text' && dt[1] is String) {
                                definitions.add(
                                  dt[1]
                                      .replaceAll(RegExp(r'\{.*?\}'), '')
                                      .trim(),
                                );
                              } else if (dt[0] == 'vis' && dt[1] is List) {
                                for (var v in dt[1]) {
                                  if (v['t'] != null) {
                                    examples.add(
                                      v['t']
                                          .toString()
                                          .replaceAll(RegExp(r'\{.*?\}'), '')
                                          .trim(),
                                    );
                                  }
                                }
                              }
                            } catch (_) {
                              continue;
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }

            // Etymology
            String etymology = '—';
            try {
              if (first['et'] != null &&
                  first['et'] is List &&
                  first['et'].isNotEmpty) {
                etymology = first['et'][0][1].toString().replaceAll(
                  RegExp(r'\{.*?\}'),
                  '',
                );
              }
            } catch (_) {}

            // ✅ Clean up definitions before displaying
            final cleanDefinitions = definitions
                .where((def) => def.trim().isNotEmpty)
                .toList();

            return ListView(
              padding: const EdgeInsets.only(top: 40),
              children: [
                Text(
                  word,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "/$pronunciation/",
                  style: const TextStyle(
                    fontFamily: 'NotoSans',
                    color: Color.fromARGB(255, 10, 132, 255),
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 36),
                Text(
                  partOfSpeech.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),

                const Text(
                  "DEFINITIONS",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Divider(color: Colors.black26, thickness: 0.88),
                const SizedBox(height: 8),

                if (cleanDefinitions.isEmpty)
                  const Text("No definitions available."),
                for (var def in cleanDefinitions)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      '— $def',
                      style: const TextStyle(fontSize: 16, height: 1.4),
                    ),
                  ),

                // Examples
                if (examples.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  const Text(
                    "Examples",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  for (var ex in examples)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "• $ex",
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                ],

                const SizedBox(height: 24),
                const Text(
                  "Etymology",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  etymology,
                  style: const TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
