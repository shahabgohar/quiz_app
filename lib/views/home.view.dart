import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/enums/difficulty.enum.dart';
import 'package:quiz_app/models/question.model.dart';
import 'package:quiz_app/repositories/quiz/quiz.repository.dart';
import 'package:quiz_app/views/widgets/build_questions.dart';

class HomePage extends ConsumerStatefulWidget {
  static const route = '/quiz';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('quiz application'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: ref.read(quizRepositoryProvider).getQuestions(
              numberOfQuestions: 10,
              categoryType: 20,
              difficulty: Difficulty.any),
          builder:
              (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
            if (snapshot.hasData) {
              return BuildQuestions(questions: snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('Error ${snapshot.error}');
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
