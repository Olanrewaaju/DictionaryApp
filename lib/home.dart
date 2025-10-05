import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'apps_providers/usernamenotif.dart';
import 'word_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    final dyslexicCode = Uri.parse(
      'https://api.dictionaryapi.dev/api/v2/entries/en/dyslexic',
    );
    final dyslexicResponse = await http.get(dyslexicCode);
    if (dyslexicResponse.statusCode != 200) {
      throw Exception('There is an error fettching it');
    }

    return jsonDecode(dyslexicResponse.body) as List<dynamic>;
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
      body: Padding(
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
              onPressed: onPressed,
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
                  final dyslexic = snapshot.data!;

                  return Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 245, 245, 245),
                          spreadRadius: 3,
                          blurRadius: 40,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],

                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dyslexic[0]['word']),
                        Text(
                          dyslexic[0]['phonetics'][0]['text'],
                          style: TextStyle(
                            fontFamily: 'NotoSans_SemiCondensed',
                          ),
                        ),
                        SizedBox(height: 12),
                        Divider(color: Colors.black12),
                        Text(
                          dyslexic[0]['meanings'][0]['definitions'][0]['definition'],
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
