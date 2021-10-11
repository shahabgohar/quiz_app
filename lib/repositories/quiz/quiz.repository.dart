import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/models/question.model.dart';
import 'package:quiz_app/enums/difficulty.enum.dart';
import 'package:quiz_app/repositories/quiz/base.repository.dart';

final dioProvider = Provider<Dio>((_) => Dio());
final quizRepositoryProvider =
    Provider<QuizRepository>((ref) => QuizRepository(ref.read));

class QuizRepository extends BaseRepository {
  final Reader _read;

  QuizRepository(this._read);

  @override
  Future<List<Question>> getQuestions(
      {required int numberOfQuestions,
      required int categoryType,
      required Difficulty difficulty}) async {
    var queryParameters = {
      'amount': numberOfQuestions,
      'category': categoryType,
      'type': 'multiple'
    };
    if (difficulty != Difficulty.any) {
      queryParameters.addAll({
        'difficulty': EnumToString.convertToString(difficulty),
      });
    }
    try {
      final response = await _read(dioProvider)
          .get('https://opentdb.com/api.php', queryParameters: queryParameters);
      if (response.statusCode == 200) {
        List<dynamic> results = response.data['results'];
        List<Question> questionsList = [];
        results.forEach((element) {
          final Question question = Question.fromJson(element);
          questionsList.add(question);
        });
        return questionsList;
      }
      return [];
    } on DioError catch (err) {
      throw err;
    }
  }
}
