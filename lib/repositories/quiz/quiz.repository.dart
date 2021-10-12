import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/models/question.model.dart';
import 'package:quiz_app/enums/difficulty.enum.dart';
import 'package:quiz_app/repositories/quiz/base.repository.dart';

final dioProvider =
    Provider<Dio>((_) => Dio(BaseOptions(baseUrl: 'https://opentdb.com/')));
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
          .get('/api.php', queryParameters: queryParameters);
      print(response.realUri);
      List<dynamic> results = response.data['results'];
      if (response.statusCode == 200 && results.isNotEmpty) {
        return results.map((e) => Question.fromJson(e)).toList();
      }
      return [];
    } on DioError catch (err) {
      throw err;
      print(err);
    }
  }
}
