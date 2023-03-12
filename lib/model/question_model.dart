class Question {
  final String questionText;
  final List<Answer> answerList;

  Question(this.questionText, this.answerList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions(){
  List<Question> list = [];

  list.add(
    Question("Who is the owner of Flutter?",
      [
        Answer("Microsoft", false),
        Answer("Google", true),
        Answer("Github", false),
        Answer("LinkedIn", false)
      ]
    )
  );

  list.add(
      Question("Flutter is a?",
          [
            Answer("Language", false),
            Answer("Game", false),
            Answer("Book", false),
            Answer("Framework", true)
          ]
      )
  );

  list.add(
      Question("Which language does Flutter use?",
          [
            Answer("C++", false),
            Answer("Python", false),
            Answer("Dart", true),
            Answer("Kotlin", false)
          ]
      )
  );

  list.add(
      Question("Which platform does Flutter supports?",
          [
            Answer("Android", false),
            Answer("iOS", false),
            Answer("Web", false),
            Answer("All of the above", true)
          ]
      )
  );

  return list;
}