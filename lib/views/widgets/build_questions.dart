import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.model.dart';

class BuildQuestions extends StatelessWidget {
  final List<Question> questions;
  const BuildQuestions({Key? key, required this.questions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);
    return PageView(
      controller: pageController,
      children: [
        ...questions
            .map((question) => _questionWithOptions(context, question))
            .toList()
      ],
    );
  }

  Widget _questionWithOptions(BuildContext context, Question question) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          question.question ?? 'sorry not found',
          style: Theme.of(context).textTheme.headline2,
        ),
        _buildOptions(context, question.answers)
      ],
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
