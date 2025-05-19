import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_progress.dart';

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Badges'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Consumer<UserProgress>(
        builder: (context, userProgress, child) {
          final earnedBadges = userProgress.earnedBadges;
          final allBadges = [
            'Bitcoin Beginner',
            'Crypto Curious',
            'Bitcoin Enthusiast',
            'Consistent Learner',
            'Transaction Expert',
            'Wallet Master',
            'Mining Expert',
          ];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Earned Badges: ${earnedBadges.length}/${allBadges.length}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: allBadges.length,
                    itemBuilder: (context, index) {
                      final badge = allBadges[index];
                      final isEarned = earnedBadges.contains(badge);

                      return _buildBadgeCard(context, badge, isEarned);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBadgeCard(BuildContext context, String badge, bool isEarned) {
    return Card(
      color: isEarned ? const Color(0xFF2A2A2A) : Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getBadgeIcon(badge),
              size: 48,
              color: isEarned ? Colors.amber : Colors.grey[700],
            ),
            const SizedBox(height: 12),
            Text(
              badge,
              style: TextStyle(
                color: isEarned ? Colors.white : Colors.grey[500],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getBadgeIcon(String badge) {
    switch (badge) {
      case 'Bitcoin Beginner':
        return Icons.school;
      case 'Crypto Curious':
        return Icons.search;
      case 'Bitcoin Enthusiast':
        return Icons.star;
      case 'Consistent Learner':
        return Icons.local_fire_department;
      case 'Transaction Expert':
        return Icons.swap_horiz;
      case 'Wallet Master':
        return Icons.account_balance_wallet;
      case 'Mining Expert':
        return Icons.memory;
      default:
        return Icons.emoji_events;
    }
  }
}