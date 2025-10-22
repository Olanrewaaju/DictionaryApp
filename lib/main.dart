import 'package:dictionary_app/apps_providers/theme_notifier.dart';
import 'package:dictionary_app/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'apps_providers/usernamenotif.dart';
import 'apps_providers/wordvalue.dart';
import 'bottom_nav.dart';
import 'package:dictionary_app/apps_providers/star_Notifier.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Usernamenotif()),
        ChangeNotifierProvider(create: (_) => Wordvalue()),
        ChangeNotifierProvider(create: (_) => DictionaryStateProvider()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
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
    final themeNotifier = context.watch<ThemeNotifier>();
    return MaterialApp(
      title: 'Flutter Demo',

      theme: themeNotifier.currentTheme,
      home: const Login(),
    );
  }
}
