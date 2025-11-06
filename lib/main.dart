import 'package:dictionary_app/state_management/theme_notifier.dart';
import 'package:dictionary_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state_management/usernamenotif.dart';
import 'state_management/wordvalue.dart';
import 'state_management/star_notifier.dart';
import 'database/sql_theme.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await SqlTheme.instance ;

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
