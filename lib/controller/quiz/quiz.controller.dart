import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/controller/quiz/quiz.state.dart';
import 'package:quiz_app/models/question.model.dart';

final quizControllerProvider =
    StateNotifierProvider.autoDispose<QuizController, QuizState>(
        (ref) => QuizController());

class QuizController extends StateNotifier<QuizState> {
  QuizController() : super(QuizState.initial());

  void checkAnswer(Question question, String answer) {
    if (question.correctAnswer == answer) {
      state = QuizState.copywith(
          correctAnswered: [question, ...state.correctAnswered],
          incorrectAnswered: state.incorrectAnswered);
    } else {
      state = QuizState.copywith(
          correctAnswered: state.correctAnswered,
          incorrectAnswered: [question, ...state.incorrectAnswered]);
    }
  }

  Map<String, int> quizResult() {
    return {"total": 10, "score": 8};
  }
}
