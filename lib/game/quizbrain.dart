import 'package:vocabulary_learning_app/game/question.dart';

class QuizBrain {
  List<Question> questions;
  QuizBrain(List<Question> questions)
  {
    this.questions = questions;
  }
  
  String getQuestion(int questionNumber)
  {
    return questions[questionNumber].question;
  }

  String getCorrectAnswer(int questionNumber)
  {
    return questions[questionNumber].answer;
  }

  int getLength()
  {
    return questions.length;
  }
}