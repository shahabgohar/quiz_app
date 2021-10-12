class Question {
  Question({
    required category,
    required type,
    required difficulty,
    required question,
    required correctAnswer,
    required answers,
  });

  late final String category;
  late final String type;
  late final String difficulty;
  late final String? question = 'fdsfs';
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

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      category: json["category"],
      type: json["type"],
      difficulty: json["difficulty"],
      question: json["question"],
      correctAnswer: json["correct_answer"],
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
}
