import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controller/provider_file.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/score_page.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late List<Question> questionList;
  late int currentQuestionIndex;
  late int score;
  late Answer? selectedAnswer;
  late int _timeLeft;
  late int _totalTimeLeft;
  late int _startTime;
  late Timer _timer;

  static const int questionDuration = 25;

  @override
  void initState() {
    super.initState();
    questionList = getQuestions(); // Initialize the questions
    questionList.shuffle(); // Shuffle the questions once when the quiz starts
    currentQuestionIndex = 0; // Start at the first question
    score = 0; // Initialize the score
    selectedAnswer = null;
    _timeLeft = questionDuration; // Time for each question
    _totalTimeLeft = questionDuration * questionList.length; // Total time for the quiz
    _startTime = DateTime.now().millisecondsSinceEpoch; // Record the start time
    startTimer(); // Start the timer
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          handleTimeout();
        }
        if (_totalTimeLeft > 0) {
          _totalTimeLeft--;
        } else {
          _timer.cancel();
          navigateToScorePage();
        }
      });
    });
  }

  void handleTimeout() {
    if (currentQuestionIndex < questionList.length - 1) {
      setState(() {
        selectedAnswer = null;
        currentQuestionIndex++;
        _timeLeft = questionDuration;
      });
    } else {
      _timer.cancel();
      navigateToScorePage();
    }
  }

  void navigateToScorePage() async {
    int endTime = DateTime.now().millisecondsSinceEpoch;
    int timeTaken = (endTime - _startTime) ~/ 1000;
    final functionProvdr =
        Provider.of<FunctionsProvider>(context, listen: false);
    await functionProvdr.uploadImageAndName(
        context: context, score: score, timeTaken: timeTaken);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ScorePage(
          score: score,
          totalQuestions: questionList.length,
          timeTaken: timeTaken,
        ),
      ),
    );
  }

  String formatTotalTime(int timeInSeconds) {
    int minutes = timeInSeconds ~/ 60;
    int seconds = timeInSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var blockWidth = screenWidth / 100;
    var blockHeight = screenHeight / 100;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          HexColor('#FF671F').withOpacity(.6),
          HexColor('#FFFFFF'),
          HexColor(
            '#046A38',
          ).withOpacity(.6)
        ])),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: blockWidth * 4, vertical: blockHeight * 3),
              child: Column(
                children: [
                  _totalTimerWidget(blockWidth),
                  SizedBox(height: blockHeight * 4),
                  _questionWidget(blockWidth),
                  SizedBox(height: blockHeight * 2),
                  _timerWidget(blockHeight),
                  SizedBox(height: blockHeight * 2),
                  _answerList(blockWidth),
                  SizedBox(height: blockHeight * 3),
                  _nextButton(blockWidth, blockHeight),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _totalTimerWidget(double blockWidth) {
    return Container(
      alignment: Alignment.topRight,
      child: Text(
        'Total Time: ${formatTotalTime(_totalTimeLeft)}',
        style: TextStyle(
            color: Colors.black,
            fontSize: blockWidth * 4,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _questionWidget(double blockWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Question ${currentQuestionIndex + 1}/${questionList.length.toString()}',
          style: TextStyle(
              color: Colors.black,
              fontSize: blockWidth * 5,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 30),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: EdgeInsets.all(blockWidth * 8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Text(
            questionList[currentQuestionIndex].questionText,
            style: TextStyle(
                color: Colors.black,
                fontSize: blockWidth * 5.5,
                fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }

  Widget _answerList(double blockWidth) {
    return Column(
      children: questionList[currentQuestionIndex]
          .answersList
          .map((e) => _answerButton(e, blockWidth))
          .toList(),
    );
  }

  Widget _answerButton(Answer answer, double blockWidth) {
    bool isSelected = answer == selectedAnswer;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: blockWidth * 5),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: blockWidth * 12,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: isSelected ? Colors.blue.shade200 : Colors.white,
          ),
          onPressed: () {
            setState(() {
              selectedAnswer = answer;
            });
          },
          child: Text(
            answer.answerText,
            style: TextStyle(fontSize: blockWidth * 5, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _timerWidget(double blockHeight) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: blockHeight * 1.5),
      child: Text(
        'Time left: $_timeLeft seconds',
        style: TextStyle(
            color: Colors.black,
            fontSize: blockHeight * 2.2,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _nextButton(double blockWidth, double blockHeight) {
    bool isLastQuestion = currentQuestionIndex == questionList.length - 1;
    return Consumer<FunctionsProvider>(
      builder: (context, provider, child) {
        return Container(
          width: blockWidth * 50,
          margin: EdgeInsets.symmetric(vertical: blockHeight * 2),
          height: blockHeight * 6,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: provider.isLoading ? Colors.grey : Colors.black,
            ),
            onPressed: provider.isLoading
                ? null
                : () async {
                    if (selectedAnswer != null && selectedAnswer!.isCorrect) {
                      score++;
                    }
                    if (isLastQuestion) {
                      navigateToScorePage();
                    } else {
                      setState(() {
                        selectedAnswer = null;
                        currentQuestionIndex++;
                        _timeLeft = questionDuration;
                      });
                    }
                  },
            child: provider.isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    isLastQuestion ? 'Submit' : 'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: blockWidth * 4.5,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
