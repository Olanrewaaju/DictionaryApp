import 'package:dictionary_app/apps_providers/wordvalue.dart';
import 'package:dictionary_app/full_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'apps_providers/usernamenotif.dart';
import 'word_screen.dart';
import 'api_container.dart';
import 'hom_container.dart';
import 'apps_providers/theme_notifier.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> values = [
    'Voluminous',
    'Silhouette',
    'colleague',
    'Expectorant',
  ];
  String dyslexicName = '';
  String dyslexicTranscription = '';
  String dyslexicDDefinition = '';
  String ephemeralName = '';
  String ephemeralTranscription = '';
  String ephemeralDefinition = '';

  String garmentName = '';
  String garmentTranscription = '';
  String garmentDefinition = '';

  String convictName = '';
  String convictTranscription = '';
  String convictDefinition = '';
  String convictSecond = '';

  String refuseName = '';
  String refuseTranscription = '';
  String refuseDefinition = '';
  String refuseSecond = '';

  late Future value;
  String name = 'Polymath';

  void onPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WordScreen();
        },
      ),
    );
  }

  Future<List<dynamic>> wotd() async {
    final dyslexicUrl = Uri.parse(
      'https://www.dictionaryapi.com/api/v3/references/collegiate/json/voluminous?key=2afc2bda-51f6-4b3c-b99a-a5997a238778',
    );
    final ephemeralUrl = Uri.parse(
      'https://www.dictionaryapi.com/api/v3/references/collegiate/json/silhouette?key=2afc2bda-51f6-4b3c-b99a-a5997a238778',
    );
    final garmentUrl = Uri.parse(
      'https://www.dictionaryapi.com/api/v3/references/collegiate/json/colleague?key=2afc2bda-51f6-4b3c-b99a-a5997a238778',
    );
    final expectorantUrl = Uri.parse(
      'https://www.dictionaryapi.com/api/v3/references/collegiate/json/expectorant?key=2afc2bda-51f6-4b3c-b99a-a5997a238778',
    );
    final convictUrl = Uri.parse(
      'https://api.dictionaryapi.dev/api/v2/entries/en/convict',
    );
    final refuseUrl = Uri.parse(
      'https://api.dictionaryapi.dev/api/v2/entries/en/refuse',
    );
    final responses = await Future.wait([
      http.get(dyslexicUrl),
      http.get(ephemeralUrl),
      http.get(garmentUrl),
      http.get(expectorantUrl),
      http.get(convictUrl),
      http.get(refuseUrl),
    ]);
    if (responses[0].statusCode == 200 &&
        responses[1].statusCode == 200 &&
        responses[2].statusCode == 200 &&
        responses[3].statusCode == 200 &&
        responses[4].statusCode == 200 &&
        responses[5].statusCode == 200) {
      final dyslexicData = jsonDecode(responses[0].body)[0];
      final ephemeralData = jsonDecode(responses[1].body)[0];
      final garmentData = jsonDecode(responses[2].body)[0];
      final expectorantData = jsonDecode(responses[3].body)[0];
      final convictData = jsonDecode(responses[4].body)[0];
      final refuseData = jsonDecode(responses[5].body)[0];

      return [
        dyslexicData,
        ephemeralData,
        garmentData,
        expectorantData,
        convictData,
        refuseData,
      ];
    }
    // else {
    //   throw Exception('Failed to fetch words');
    // }
    else {
      print('❌ One or more requests failed!');
      print(responses.map((r) => r.statusCode).toList());
      throw Exception('Failed to fetch words');
    }
  }

  void onRessed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return FullDetail(navWord: name);
        },
      ),
    );
    context.read<Wordvalue>().wordChanger(name);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = wotd();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<Usernamenotif>().username;
    final toggles = context.watch<ThemeNotifier>().isDarkMode;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 87,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello $user',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Welcome back',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                context.read<ThemeNotifier>().toggleTheme();
              },
              icon: toggles ? Icon(Icons.dark_mode) : Icon(Icons.light_mode),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text(
                'The word of the day :',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                ),
                onPressed: onRessed,
                child: Text(
                  name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,

                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 80),
              Text('Previously Searched words', style: TextStyle(fontSize: 12)),
              SizedBox(height: 24),
              FutureBuilder(
                future: value,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      constraints: BoxConstraints.expand(height: 30, width: 30),
                    );
                  }
                  if (snapshot.hasError) {
                    // print();

                    return SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(child: Text('Error: ${snapshot.error}')),
                    );
                  }
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    final dyslexic = data[0];
                    final ephemeral = data[1];
                    final garment = data[2];
                    final expectorant = data[3];
                    final convict = data[4];
                    final refuse = data[5];

                    // Assuming `dyslexic` is your decoded JSON map for a single word
                    // Dyslexic
                    final String dyslexicName =
                        dyslexic['meta']?['id']?.split(':')[0] ?? '';
                    final String dyslexicTranscription =
                        (dyslexic['hwi']?['prs'] != null &&
                            dyslexic['hwi']['prs'].isNotEmpty)
                        ? dyslexic['hwi']['prs'][0]['mw'] ?? ''
                        : '';
                    final List<String> dyslexicShortDefs = List<String>.from(
                      dyslexic['shortdef'] ?? [],
                    );
                    final String dyslexicDefinition =
                        dyslexicShortDefs.isNotEmpty
                        ? dyslexicShortDefs[0]
                        : '';

                    // Ephemeral
                    final String ephemeralName =
                        ephemeral['meta']?['id']?.split(':')[0] ?? '';
                    final String ephemeralTranscription =
                        (ephemeral['hwi']?['prs'] != null &&
                            ephemeral['hwi']['prs'].isNotEmpty)
                        ? ephemeral['hwi']['prs'][0]['mw'] ?? ''
                        : '';
                    final List<String> ephemeralShortDefs = List<String>.from(
                      ephemeral['shortdef'] ?? [],
                    );
                    final String ephemeralDefinition =
                        ephemeralShortDefs.isNotEmpty
                        ? ephemeralShortDefs[0]
                        : '';

                    // Garment
                    final String garmentName =
                        garment['meta']?['id']?.split(':')[0] ?? '';
                    final String garmentTranscription =
                        (garment['hwi']?['prs'] != null &&
                            garment['hwi']['prs'].isNotEmpty)
                        ? garment['hwi']['prs'][0]['mw'] ?? ''
                        : '';
                    final List<String> garmentShortDefs = List<String>.from(
                      garment['shortdef'] ?? [],
                    );
                    final String garmentDefinition = garmentShortDefs.isNotEmpty
                        ? garmentShortDefs[0]
                        : '';

                    // Expectorant
                    final String expectorantName =
                        expectorant['meta']?['id']?.split(':')[0] ?? '';
                    final String expectorantTranscription =
                        (expectorant['hwi']?['prs'] != null &&
                            expectorant['hwi']['prs'].isNotEmpty)
                        ? expectorant['hwi']['prs'][0]['mw'] ?? ''
                        : '';
                    final List<String> expectorantShortDefs = List<String>.from(
                      expectorant['shortdef'] ?? [],
                    );
                    final String expectorantDefinition =
                        expectorantShortDefs.isNotEmpty
                        ? expectorantShortDefs[0]
                        : '';

                    convictName = convict['word'] ?? '';
                    convictTranscription =
                        (convict['phonetics'] != null &&
                            convict['phonetics'].isNotEmpty)
                        ? convict['phonetics'][0]['text'] ?? ''
                        : '';
                    convictDefinition =
                        convict['meanings'][0]['definitions'][0]['definition'] ??
                        '';
                    convictSecond =
                        convict['meanings'][0]['definitions'][1]['definition'] ??
                        '';

                    refuseName = refuse['word'] ?? '';
                    refuseTranscription =
                        (refuse['phonetics'] != null &&
                            refuse['phonetics'].isNotEmpty)
                        ? refuse['phonetics'][0]['text'] ?? ''
                        : '';
                    refuseDefinition =
                        refuse['meanings'][0]['definitions'][0]['definition'] ??
                        '';
                    // refuseSecond =
                    //     refuse['meanings'][0]['definitions'][1]['definition'] ??
                    //     '';
                    refuseSecond =
                        refuse['meanings'][1]['definitions'][0]['definition'] ??
                        '';
                    return Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          // padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return FullDetail(navWord: values[0]);
                                      },
                                    ),
                                  );
                                  context.read<Wordvalue>().wordChanger(
                                    values[0],
                                  );
                                },

                                child: ApiContainer(
                                  name: dyslexicName,
                                  transcription: dyslexicTranscription,
                                  definition: dyslexicDefinition,
                                ),
                              ),
                              SizedBox(width: 12),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return FullDetail(navWord: values[0]);
                                      },
                                    ),
                                  );
                                  context.read<Wordvalue>().wordChanger(
                                    values[1],
                                  );
                                },
                                child: ApiContainer(
                                  name: ephemeralName,
                                  transcription: ephemeralTranscription,
                                  definition: ephemeralDefinition,
                                ),
                              ),
                              SizedBox(width: 12),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return FullDetail(navWord: values[0]);
                                      },
                                    ),
                                  );
                                  context.read<Wordvalue>().wordChanger(
                                    values[2],
                                  );
                                },
                                child: ApiContainer(
                                  name: garmentName,
                                  transcription: garmentTranscription,
                                  definition: garmentDefinition,
                                ),
                              ),
                              SizedBox(width: 12),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return FullDetail(navWord: values[0]);
                                      },
                                    ),
                                  );
                                  context.read<Wordvalue>().wordChanger(
                                    values[3],
                                  );
                                },
                                child: ApiContainer(
                                  name: expectorantName,
                                  transcription: expectorantTranscription,
                                  definition: expectorantDefinition,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Common Homonyms',

                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              HomContainer(
                                name: convictName,
                                transcription: convictTranscription,
                                firstdefinition: convictDefinition,
                                seconddefinition: convictSecond,
                              ),
                              SizedBox(width: 12),

                              HomContainer(
                                name: refuseName,
                                transcription: refuseTranscription,
                                firstdefinition: refuseDefinition,
                                seconddefinition: refuseSecond,
                              ),
                              SizedBox(width: 12),

                              HomContainer(
                                name: convictName,
                                transcription: convictTranscription,
                                firstdefinition: convictDefinition,
                                seconddefinition: 'seconddefinition',
                              ),
                              SizedBox(width: 12),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
