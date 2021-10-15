import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/views/home.view.dart';
import 'package:quiz_app/views/quiz_setup.view.dart';
import 'package:quiz_app/views/score.view.dart';

import 'Log/logger.dart';

void main() {
  runApp(ProviderScope(observers: [Logger()], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        QuizSetup.route: (context) => QuizSetup(),
        HomePage.route: (context) => HomePage(),
        Score.route: (context) => Score()
      },
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
              headline2: TextStyle(
                  color: Colors.black, fontSize: 30.0, wordSpacing: 10.0))),
      home: QuizSetup(),
    );
  }
}
