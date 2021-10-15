import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/controller/quiz/quiz.controller.dart';
import 'package:quiz_app/views/quiz_setup.view.dart';

class Score extends ConsumerWidget {
  static const route = '/score';
  const Score({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.read(quizControllerProvider.notifier).quizResult();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('your total score is: '),
              Text('${result['score']}/${result['total']}'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        QuizSetup.route, (route) => false);
                  },
                  child: Text('Want to restart again ?'))
            ],
          ),
        ),
      ),
    );
  }
}
