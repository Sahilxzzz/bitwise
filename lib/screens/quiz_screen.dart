import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/module.dart';
import '../models/user_progress.dart';
import 'badge_earned_screen.dart';

class QuizScreen extends StatefulWidget {
  final Module module;

  const QuizScreen({super.key, required this.module});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuizIndex = 0;
  int _score = 0;
  bool _hasAnswered = false;
  int? _selectedAnswerIndex;

  @override
  Widget build(BuildContext context) {
    final quiz = widget.module.quizzes[_currentQuizIndex];
    final isLastQuiz = _currentQuizIndex == widget.module.quizzes.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quiz progress
            Row(
              children: [
                Text(
                  'Question ${_currentQuizIndex + 1} of ${widget.module.quizzes.length}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Spacer(),
                Text(
                  'Score: $_score',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: (_currentQuizIndex + 1) / widget.module.quizzes.length,
              backgroundColor: Colors.grey[800],
              color: Theme.of(context).primaryColor,
              minHeight: 6,
            ),

            const SizedBox(height: 24),

            // Question
            Text(
              quiz.question,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 20),
            ),

            const SizedBox(height: 24),

            // Answer options
            Expanded(
              child: ListView.builder(
                itemCount: quiz.options.length,
                itemBuilder: (context, index) {
                  final isCorrect = index == quiz.correctAnswerIndex;
                  Color? backgroundColor;

                  if (_hasAnswered) {
                    if (isCorrect) {
                      backgroundColor = Colors.green.withOpacity(0.3);
                    } else if (_selectedAnswerIndex == index) {
                      backgroundColor = Colors.red.withOpacity(0.3);
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: GestureDetector(
                      onTap: _hasAnswered ? null : () {
                        setState(() {
                          _selectedAnswerIndex = index;
                          _hasAnswered = true;
                          if (isCorrect) {
                            _score++;
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: backgroundColor ?? Colors.grey[800],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _selectedAnswerIndex == index
                                ? Theme.of(context).primaryColor
                                : Colors.grey[700]!,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${String.fromCharCode(65 + index)}.',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                quiz.options[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            if (_hasAnswered && isCorrect)
                              const Icon(Icons.check_circle, color: Colors.green),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Next button
            Center(
              child: ElevatedButton(
                onPressed: !_hasAnswered ? null : () {
                  if (isLastQuiz) {
                    // Complete module and navigate to badge earned screen
                    Provider.of<UserProgress>(context, listen: false)
                        .completeModule(widget.module);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BadgeEarnedScreen(
                          module: widget.module,
                          score: _score,
                          totalQuestions: widget.module.quizzes.length,
                        ),
                      ),
                    );
                  } else {
                    // Move to next question
                    setState(() {
                      _currentQuizIndex++;
                      _hasAnswered = false;
                      _selectedAnswerIndex = null;
                    });
                  }
                },
                child: Text(isLastQuiz ? 'Finish Quiz' : 'Next Question'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}