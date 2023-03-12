import 'package:flutter/material.dart';
import 'package:simple_quiz_app/home_page.dart';

import 'model/question_model.dart';

class QuizScreen extends StatefulWidget {
  final String? name;
  const QuizScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Question ${currentQuestionIndex + 1}"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            _questionWidget(),
            const SizedBox(
              height: 24,
            ),
            _answerList(),
            const SizedBox(
              height: 36,
            ),
            _nextButton()
          ],
        ),
      ),
    );
  }

  _questionWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.amber.shade300,
          borderRadius: BorderRadius.circular(16)),
      child: Text(questionList[currentQuestionIndex].questionText),
    );
  }

  _showScoreDialog() {
    bool isPassed = false;

    if (score >= questionList.length * 0.6) {
      // pass if 60%
      isPassed = true;
    }

    String name = "";

    if(widget.name != null){
      name = widget.name!;
    }

    String title = isPassed ? "Passed" : "Failed";

    return AlertDialog(
      title: Text(
        "Hi $name!\nYou $title this test\nYour score is $score",
        style: TextStyle(color: isPassed ? Colors.green : Colors.red),
      ),
      content: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
          setState(() {
            currentQuestionIndex = 0;
            score = 0;
            selectedAnswer = null;
          });
        },
        child: const Text("Restart"),
      ),
    );
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: MediaQuery.of(context).size.width * 0.5,
      height: 42,
      child: ElevatedButton(
          onPressed: () {
            if (isLastQuestion) {
              // display score
              showDialog(context: context, builder: (_) => _showScoreDialog());
            } else {
              // show next question
              setState(() {
                selectedAnswer = null;
                currentQuestionIndex++;
              });
            }
          },
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black87),
          child: Text(isLastQuestion ? "Submit" : "Next")),
    );
  }

  _answerList() {
    Widget _answerButton(Answer answer) {
      bool isSelected = answer == selectedAnswer;
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        width: double.infinity,
        height: 42,
        child: ElevatedButton(
            onPressed: () {
              if (selectedAnswer == null) {
                if (answer.isCorrect) {
                  score++;
                }
                setState(() {
                  selectedAnswer = answer;
                });
              }
            },
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor:
                    isSelected ? Colors.amber.shade300 : Colors.amber.shade100,
                foregroundColor:
                    isSelected ? Colors.grey.shade800 : Colors.amber.shade800),
            child: Text(answer.answerText)),
      );
    }

    return Column(
      children: questionList[currentQuestionIndex]
          .answerList
          .map((e) => _answerButton(e))
          .toList(),
    );
  }
}
