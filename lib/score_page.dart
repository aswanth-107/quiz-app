import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controller/provider_file.dart';

// Stateless widget to display the score page
class ScorePage extends StatelessWidget {
  final int score; // The score obtained by the user
  final int totalQuestions; // Total number of questions in the quiz
  final int timeTaken; // Time taken to complete the quiz

  const ScorePage({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.timeTaken,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FunctionsProvider>(
      builder: (context, functionProvdr, child) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            HexColor('#FF671F').withOpacity(.6),
            HexColor('#	FFFFFF'),
            HexColor(
              '#046A38',
            ).withOpacity(.6)
          ])),
          child: SafeArea(
            child: Stack(
              children: [
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: const Text(
                      'Quiz Result',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Centers the content vertically
                    children: [
                      const Text(
                        'Your Score',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight
                                .bold), // Styling for "Your Score" text
                      ),
                      const SizedBox(height: 20), // Adds space between elements
                      Text(
                        '$score / $totalQuestions', // Displays the score out of total questions
                        style: const TextStyle(
                            fontSize: 48,
                            fontWeight:
                                FontWeight.bold), // Styling for score text
                      ),
                      const SizedBox(height: 20), // Adds space between elements
                      Text(
                        'Time Taken: $timeTaken seconds', // Displays the time taken to complete the quiz
                        style: const TextStyle(
                            fontSize: 18), // Styling for time taken text
                      ),
                      const SizedBox(height: 40), // Adds space between elements
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
