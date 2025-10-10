import 'package:dictionary_app/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'apps_providers/usernamenotif.dart';
import 'apps_providers/wordvalue.dart';
import 'bottom_nav.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Usernamenotif()),
        ChangeNotifierProvider(create: (_) => Wordvalue()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(4),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(
              const Color.fromARGB(255, 10, 132, 255),
            ),
          ),
        ),
        fontFamily: 'Manrope',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const BottomNavBar(),
    );
  }
}
