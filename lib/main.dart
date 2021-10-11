import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/enums/difficulty.enum.dart';
import 'package:quiz_app/repositories/quiz/quiz.repository.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(quizRepositoryProvider);
    return Scaffold(
      appBar: AppBar(title: Text('quiz app')),
      body: Center(
        child: ElevatedButton(
          child: Text('click me'),
          onPressed: () async {
            final questions = await provider.getQuestions(
                numberOfQuestions: 10,
                categoryType: 20,
                difficulty: Difficulty.any);
            print(questions);
          },
        ),
      ),
    );
  }
}
