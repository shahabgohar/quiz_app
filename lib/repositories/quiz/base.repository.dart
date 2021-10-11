import 'package:quiz_app/enums/difficulty.enum.dart';
import 'package:quiz_app/models/question.model.dart';

abstract class BaseRepository {
  Future<List<Question>> getQuestions(
      {required int numberOfQuestions,
      required int categoryType,
      required Difficulty difficulty});
}
