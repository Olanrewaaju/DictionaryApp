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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      'https://api.dictionaryapi.dev/api/v2/entries/en/dyslexic',
    );
    final ephemeralUrl = Uri.parse(
      'https://api.dictionaryapi.dev/api/v2/entries/en/ephemeral',
    );
    final garmentUrl = Uri.parse(
      'https://api.dictionaryapi.dev/api/v2/entries/en/garment',
    );
    final expectorantUrl = Uri.parse(
      'https://api.dictionaryapi.dev/api/v2/entries/en/expectorant',
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
    } else {
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 87,
        automaticallyImplyLeading: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello $user', style: TextStyle()),
            SizedBox(height: 8),
            Text(
              'Welcome back',
              style: TextStyle(fontSize: 14, color: Colors.black45),
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
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
              TextButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                ),
                onPressed: onRessed,
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
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

                    final dyslexicName = dyslexic['word'] ?? '';
                    final dyslexicTranscription =
                        dyslexic['phonetics'] != null &&
                            dyslexic['phonetics'].isNotEmpty
                        ? dyslexic['phonetics'][0]['text'] ?? ''
                        : '';
                    final dyslexicDefinition =
                        dyslexic['meanings'][0]['definitions'][0]['definition'] ??
                        '';

                    final ephemeralName = ephemeral['word'] ?? '';
                    final ephemeralTranscription =
                        ephemeral['phonetics'] != null &&
                            ephemeral['phonetics'].isNotEmpty
                        ? ephemeral['phonetics'][0]['text'] ?? ''
                        : '';
                    final ephemeralDefinition =
                        ephemeral['meanings'][0]['definitions'][0]['definition'] ??
                        '';
                    final garmentName = garment['word'] ?? '';
                    final garmentTranscription =
                        garment['phonetics'] != null &&
                            garment['phonetics'].isNotEmpty
                        ? garment['phonetics'][0]['text'] ?? ''
                        : '';
                    final garmentDefinition =
                        garment['meanings'][0]['definitions'][0]['definition'] ??
                        '';

                    final expectorantName = expectorant['word'] ?? '';
                    final expectorantTranscription =
                        expectorant['phonetics'] != null &&
                            expectorant['phonetics'].isNotEmpty
                        ? expectorant['phonetics'][0]['text'] ?? ''
                        : '';
                    final expectorantDefinition =
                        expectorant['meanings'][0]['definitions'][0]['definition'] ??
                        '';

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
                              ApiContainer(
                                name: dyslexicName,
                                transcription: dyslexicTranscription,
                                definition: dyslexicDefinition,
                              ),
                              SizedBox(width: 12),
                              ApiContainer(
                                name: ephemeralName,
                                transcription: ephemeralTranscription,
                                definition: ephemeralDefinition,
                              ),
                              SizedBox(width: 12),
                              ApiContainer(
                                name: garmentName,
                                transcription: garmentTranscription,
                                definition: garmentDefinition,
                              ),
                              SizedBox(width: 12),
                              ApiContainer(
                                name: expectorantName,
                                transcription: expectorantTranscription,
                                definition: expectorantDefinition,
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
                                style: TextStyle(fontSize: 12),
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
