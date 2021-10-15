import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/controller/quiz/quiz.controller.dart';
import 'package:quiz_app/models/question.model.dart';
import 'package:quiz_app/views/score.view.dart';

class BuildQuestions extends ConsumerStatefulWidget {
  final List<Question> questions;
  const BuildQuestions({Key? key, required this.questions}) : super(key: key);

  @override
  _BuildQuestionsState createState() => _BuildQuestionsState();
}

class _BuildQuestionsState extends ConsumerState<BuildQuestions> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = new PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ...widget.questions
            .map((question) => _questionWithOptions(context, question))
            .toList()
      ],
    );
  }

  Widget _questionWithOptions(BuildContext context, Question question) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question.question,
          style: Theme.of(context).textTheme.headline2,
        ),
        _buildOptions(context, question)
      ],
    );
  }

  Widget _buildOptions(BuildContext context, Question question) {
    final checkExisting =
        ref.watch(quizControllerProvider).checkIFAnswered(question);
// if the question is not answered previously then it will be null
    return checkExisting == null
        ? Expanded(
            child: ListView(
              children: [
                ...question.answers.map((answer) {
                  return _buildOptionTile(context, answer, question,
                      Colors.yellow, Icons.circle_outlined);
                }).toList()
              ],
            ),
          )
        : Expanded(
            child: IgnorePointer(
              child: ListView(
                children: [
                  ...question.answers.map((answer) {
                    if (question.correctAnswer == answer) {
                      return _buildOptionTile(
                          context, answer, question, Colors.green, Icons.done);
                    } else {
                      return _buildOptionTile(
                          context, answer, question, Colors.red, Icons.close);
                    }
                  }).toList()
                ],
              ),
            ),
          );
  }

  Widget _buildOptionTile(BuildContext context, String answer,
      Question question, MaterialColor color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
          selectedTileColor: color,
          leading: Icon(icon),
          tileColor: color,
          title: Text(answer),
          onTap: () {
            ref
                .read(quizControllerProvider.notifier)
                .checkAnswer(question, answer);
            if (pageController.page!.toInt() == 9) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Score.route, (route) => false);
            } else {
              pageController.nextPage(
                  duration: const Duration(seconds: 1), curve: Curves.bounceIn);
            }
          }),
    );
  }
}
