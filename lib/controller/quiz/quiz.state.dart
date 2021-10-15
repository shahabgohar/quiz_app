import 'package:quiz_app/models/question.model.dart';
import 'package:collection/collection.dart';

class QuizState {
  final List<Question> correctAnswered;
  final List<Question> incorrectAnswered;
  QuizState({required this.correctAnswered, required this.incorrectAnswered});
  QuizState.initial(
      {this.correctAnswered = const [], this.incorrectAnswered = const []});

  Question? _getCorrectAnswered(Question question) {
    if (correctAnswered.isNotEmpty) {
      return correctAnswered.firstWhereOrNull((element) => element == question);
    } else {
      return null;
    }
  }

  Question? _getIncorrectAnswered(Question question) {
    if (incorrectAnswered.isNotEmpty) {
      return incorrectAnswered
          .firstWhereOrNull((element) => element.question == question.question);
    } else {
      return null;
    }
  }

  Question? checkIFAnswered(Question question) {
    return _getCorrectAnswered(question) ?? _getIncorrectAnswered(question);
  }

  static QuizState copywith(
      {required List<Question> correctAnswered,
      required List<Question> incorrectAnswered}) {
    return QuizState(
        correctAnswered: correctAnswered, incorrectAnswered: incorrectAnswered);
  }

  @override
  String toString() {
    return correctAnswered.toString();
  }
}
