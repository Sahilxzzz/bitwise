import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_progress.dart';

class DailyChallengeScreen extends StatefulWidget {
  const DailyChallengeScreen({super.key});

  @override
  State<DailyChallengeScreen> createState() => _DailyChallengeScreenState();
}

class _DailyChallengeScreenState extends State<DailyChallengeScreen> {
  final List<DailyChallenge> _dailyChallenges = [
    DailyChallenge(
      id: 1,
      title: 'Bitcoin Quiz',
      description: 'Complete a 5-question quiz about Bitcoin fundamentals',
      xpReward: 150,
      iconData: Icons.quiz,
      color: Colors.blue,
    ),
    DailyChallenge(
      id: 2,
      title: 'Blockchain Terms',
      description: 'Match 8 blockchain terms with their correct definitions',
      xpReward: 180,
      iconData: Icons.compare_arrows,
      color: Colors.purple,
    ),
    DailyChallenge(
      id: 3,
      title: 'Transaction Simulation',
      description: 'Complete a Bitcoin transaction simulation exercise',
      xpReward: 200,
      iconData: Icons.currency_bitcoin,
      color: Colors.orange,
    ),
  ];

  // Get a random challenge each day, but keep it consistent for the day
  DailyChallenge _getTodayChallenge() {
    // Use the current date as a seed for the random selection
    // This ensures the same challenge is shown all day
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
    final challengeIndex = dayOfYear % _dailyChallenges.length;
    return _dailyChallenges[challengeIndex];
  }

  @override
  Widget build(BuildContext context) {
    final userProgress = Provider.of<UserProgress>(context);
    final todayChallenge = _getTodayChallenge();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Challenge'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(userProgress),
              const SizedBox(height: 24),
              _buildChallengeCard(context, todayChallenge, userProgress),
              const SizedBox(height: 24),
              _buildBenefitsSection(),
              const SizedBox(height: 24),
              _buildStreakSection(userProgress),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(UserProgress userProgress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Challenge',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          userProgress.dailyChallengeCompleted
              ? 'You\'ve completed today\'s challenge. Great job!'
              : 'Complete daily challenges to earn XP and maintain your streak!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildChallengeCard(
      BuildContext context, DailyChallenge challenge, UserProgress userProgress) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            challenge.color,
            challenge.color.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        challenge.iconData,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            challenge.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            challenge.description,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.bolt, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '+${challenge.xpReward} XP',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (userProgress.dailyChallengeCompleted)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.white, size: 20),
                            SizedBox(width: 4),
                            Text(
                              'Completed',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (!userProgress.dailyChallengeCompleted)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the challenge screen or show a bottom sheet with the challenge
                    _showChallengeBottomSheet(context, challenge);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: challenge.color,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Start Challenge',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBenefitsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Benefits of Daily Challenges',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildBenefitItem(
          Icons.trending_up,
          'Faster Progress',
          'Earn XP faster and level up your Bitcoin knowledge.',
        ),
        const SizedBox(height: 12),
        _buildBenefitItem(
          Icons.local_fire_department,
          'Maintain Streak',
          'Keep your learning streak alive by completing daily challenges.',
        ),
        const SizedBox(height: 12),
        _buildBenefitItem(
          Icons.emoji_events,
          'Earn Special Badges',
          'Unlock exclusive badges by completing challenges consistently.',
        ),
      ],
    );
  }

  Widget _buildBenefitItem(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStreakSection(UserProgress userProgress) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'Your Learning Streak',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.local_fire_department,
                color: Colors.orange,
                size: 36,
              ),
              const SizedBox(width: 8),
              Text(
                '${userProgress.currentStreak} days',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Best streak: ${userProgress.bestStreak} days',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),
          if (userProgress.streakFreezesAvailable > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.ac_unit, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Streak freezes available: ${userProgress.streakFreezesAvailable}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _showChallengeBottomSheet(BuildContext context, DailyChallenge challenge) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            challenge.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: _buildChallengeContent(challenge),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Mark the challenge as completed
                                Provider.of<UserProgress>(context, listen: false)
                                    .completeDailyChallenge(challenge.xpReward);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Complete Challenge',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildChallengeContent(DailyChallenge challenge) {
    // This would be replaced with actual challenge content
    // For simplicity, we're just showing placeholder content
    switch (challenge.id) {
      case 1:
        return _buildQuizChallenge();
      case 2:
        return _buildMatchingChallenge();
      case 3:
        return _buildTransactionSimulation();
      default:
        return const Center(
          child: Text('Challenge content coming soon!'),
        );
    }
  }

  Widget _buildQuizChallenge() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Answer the following questions about Bitcoin:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          _buildQuizQuestion(
            'What is the maximum supply of Bitcoin?',
            ['10 million', '21 million', '100 million', 'Unlimited'],
            1,
          ),
          const SizedBox(height: 16),
          _buildQuizQuestion(
            'Who created Bitcoin?',
            ['Vitalik Buterin', 'Craig Wright', 'Satoshi Nakamoto', 'Elon Musk'],
            2,
          ),
          const SizedBox(height: 16),
          _buildQuizQuestion(
            'What year was Bitcoin launched?',
            ['2007', '2009', '2011', '2013'],
            1,
          ),
          const SizedBox(height: 16),
          _buildQuizQuestion(
            'What consensus mechanism does Bitcoin use?',
            ['Proof of Stake', 'Proof of Work', 'Proof of Authority', 'Delegated Proof of Stake'],
            1,
          ),
          const SizedBox(height: 16),
          _buildQuizQuestion(
            'What is a Bitcoin halving?',
            [
              'When the price drops by 50%',
              'When the network hash rate drops by 50%',
              'When the block reward is reduced by 50%',
              'When transaction fees are cut in half'
            ],
            2,
          ),
        ],
      ),
    );
  }

  Widget _buildQuizQuestion(String question, List<String> options, int correctIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(
          options.length,
              (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: RadioListTile<int>(
                title: Text(options[index]),
                value: index,
                groupValue: index == correctIndex ? index : null,
                onChanged: (int? value) {
                  // In a real app, you would track the user's answer
                },
                activeColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMatchingChallenge() {
    // Placeholder for matching challenge
    return const Center(
      child: Text(
        'In this challenge, you would match blockchain terms with their definitions. Drag each term to its correct definition.',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildTransactionSimulation() {
    // Placeholder for transaction simulation
    return const Center(
      child: Text(
        'In this challenge, you would simulate creating and verifying a Bitcoin transaction by following step-by-step instructions.',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class DailyChallenge {
  final int id;
  final String title;
  final String description;
  final int xpReward;
  final IconData iconData;
  final Color color;

  DailyChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.xpReward,
    required this.iconData,
    required this.color,
  });
}