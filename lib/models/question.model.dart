import 'package:equatable/equatable.dart';
import 'package:html_character_entities/html_character_entities.dart';

class Question extends Equatable {
  Question({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.answers,
  });

  late final String category;
  late final String type;
  late final String difficulty;
  late final String question;
  late final String correctAnswer;
  late final List<String> answers;

  static Question copyWith({
    required String category,
    required String type,
    required String difficulty,
    required String question,
    required String correctAnswer,
    required List<String> answers,
  }) =>
      Question(
        category: category,
        type: type,
        difficulty: difficulty,
        question: question,
        correctAnswer: correctAnswer,
        answers: answers,
      );

  static Question fromJson(Map<String, dynamic> json) {
    return Question(
      category: HtmlCharacterEntities.decode(json["category"]),
      type: HtmlCharacterEntities.decode(json["type"]),
      difficulty: HtmlCharacterEntities.decode(json["difficulty"]),
      question: HtmlCharacterEntities.decode(json["question"]),
      correctAnswer: HtmlCharacterEntities.decode(json["correct_answer"]),
      answers: List<String>.from(json["incorrect_answers"])
        ..add(json["correct_answer"])
        ..shuffle(),
    );
  }

  Map<String, dynamic> toJson() => {
        "category": category,
        "type": type,
        "difficulty": difficulty,
        "question": question,
        "correct_answer": correctAnswer,
        "incorrect_answers": List<dynamic>.from(answers.map((x) => x)),
      };

  @override
  List<Object?> get props =>
      [category, type, difficulty, question, correctAnswer, answers];
}
