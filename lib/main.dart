import 'package:flutter/material.dart';
import 'package:notes/providers/DBprovider.dart';
import 'package:notes/providers/theme_provider.dart';
import 'package:notes/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'helpers/DBHelper.dart';

void main() {
  runApp(
    MultiProvider(providers: [ChangeNotifierProvider(
        create: (context)=>DBprovider()),
        ChangeNotifierProvider(create: (context)=>theme_provider())],
        child: NotesApp()
    )
  );
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      themeMode: context.watch<theme_provider>().getTheme()?ThemeMode.dark:ThemeMode.light,
      darkTheme:ThemeData.dark(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
