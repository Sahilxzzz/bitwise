import 'package:flutter/material.dart';
import '../models/module.dart';
import 'package:confetti/confetti.dart';

class BadgeEarnedScreen extends StatefulWidget {
  final Module module;
  final int score;
  final int totalQuestions;

  const BadgeEarnedScreen({
    super.key,
    required this.module,
    required this.score,
    required this.totalQuestions,
  });

  @override
  State<BadgeEarnedScreen> createState() => _BadgeEarnedScreenState();
}

class _BadgeEarnedScreenState extends State<BadgeEarnedScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    // Start confetti animation when screen loads
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scorePercentage = (widget.score / widget.totalQuestions) * 100;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.emoji_events,
                    size: 100,
                    color: Colors.amber,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Congratulations!',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'You earned the "${widget.module.badgeEarned}" badge',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Your Score: ${widget.score}/${widget.totalQuestions} (${scorePercentage.toInt()}%)',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'You\'ve earned ${widget.module.pointsReward} XP!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Pop back to home screen
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text('Continue Learning'),
                  ),
                ],
              ),
            ),
          ),
          // Confetti effect
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
              colors: const [
                Colors.amber,
                Colors.orange,
                Colors.yellow,
                Colors.blue,
              ],
            ),
          ),
        ],
      ),
    );
  }
}