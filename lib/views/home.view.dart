import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/enums/difficulty.enum.dart';
import 'package:quiz_app/models/question.model.dart';
import 'package:quiz_app/repositories/quiz/quiz.repository.dart';

class HomePage extends ConsumerStatefulWidget {
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
      body: FutureBuilder(
        future: ref.read(quizRepositoryProvider).getQuestions(
            numberOfQuestions: 10,
            categoryType: 20,
            difficulty: Difficulty.any),
        builder:
            (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
          if (snapshot.hasData) {
            return _buildQuestions(context);
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
    );
  }

  Widget _buildQuestions(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildQuestion(context, 'question question'),
        _buildOptions(context, ['hello', 'hello'])
      ],
    );
  }

  Widget _buildQuestion(BuildContext context, String question) {
    return Text(
      question,
      style: Theme.of(context).textTheme.headline2,
    );
  }

  Widget _buildOptions(BuildContext context, List<String> answers) {
    return Expanded(
      child: ListView(
        children: [
          ...answers.map((answer) => ListTile(title: Text(answer))).toList()
        ],
      ),
    );
  }
}
