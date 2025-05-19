import 'package:flutter/foundation.dart';
import 'module.dart';

class UserProgress extends ChangeNotifier {
  int _experiencePoints = 0;
  int _level = 1;
  final Map<int, bool> _completedModules = {};
  final List<String> _earnedBadges = [];
  int _currentStreak = 0;
  int _bestStreak = 0;
  bool _dailyChallengeCompleted = false;
  int _streakFreezesAvailable = 1;
  bool _hasLeveledUp = false;
  DateTime? _lastCompletionDate;

  // Getters
  int get experiencePoints => _experiencePoints;
  int get level => _level;
  List<String> get completedModules => _completedModules.keys.where((k) => _completedModules[k] == true).map((k) => k.toString()).toList();
  int get completedModulesCount => _completedModules.values.where((v) => v).length;
  List<String> get earnedBadges => _earnedBadges;
  int get currentStreak => _currentStreak;
  int get bestStreak => _bestStreak;
  bool get dailyChallengeCompleted => _dailyChallengeCompleted;
  int get streakFreezesAvailable => _streakFreezesAvailable;
  bool get hasLeveledUp => _hasLeveledUp;

  bool isModuleCompleted(int moduleId) {
    return _completedModules[moduleId] ?? false;
  }

  void completeModule(Module module) {
    if (_completedModules[module.id] == true) {
      return; // Already completed this module
    }

    _completedModules[module.id] = true;
    _addExperiencePoints(module.pointsReward);

    // Check for streak
    final now = DateTime.now();
    if (_lastCompletionDate != null) {
      final difference = now.difference(_lastCompletionDate!).inDays;
      if (difference <= 1) {
        _currentStreak++;
      } else if (difference == 2 && _streakFreezesAvailable > 0) {
        _streakFreezesAvailable--;
        _currentStreak++;
      } else {
        _currentStreak = 1;
      }
    } else {
      _currentStreak = 1;
    }
    _lastCompletionDate = now;

    // Update best streak if current is higher
    if (_currentStreak > _bestStreak) {
      _bestStreak = _currentStreak;
    }

    // Check if earned any new badges
    _checkForBadges();

    notifyListeners();
  }

  void _addExperiencePoints(int points) {
    int oldLevel = _level;
    _experiencePoints += points;

    // Update level based on experience points
    _updateLevel();

    // Check if level increased
    if (_level > oldLevel) {
      _hasLeveledUp = true;
    }
  }

  void _updateLevel() {
    // Experience points needed for each level increases
    // Level 1: 0-999 XP
    // Level 2: 1000-1999 XP
    // Level 3: 2000-2999 XP, etc.
    _level = (_experiencePoints ~/ 1000) + 1;
  }

  void completeDailyChallenge(int xpReward) {
    _dailyChallengeCompleted = true;
    _addExperiencePoints(xpReward);

    // Update streak
    _currentStreak++;
    if (_currentStreak > _bestStreak) {
      _bestStreak = _currentStreak;
    }

    // Check for badges
    _checkForBadges();

    notifyListeners();
  }

  void resetDailyChallenge() {
    _dailyChallengeCompleted = false;
    notifyListeners();
  }

  void acknowledgeRecentLevelUp() {
    _hasLeveledUp = false;
    notifyListeners();
  }

  void _checkForBadges() {
    // Badge for completing first module
    if (completedModulesCount == 1 && !_earnedBadges.contains("Bitcoin Beginner")) {
      _earnedBadges.add("Bitcoin Beginner");
    }

    // Badge for completing 3 modules
    if (completedModulesCount >= 3 && !_earnedBadges.contains("Crypto Curious")) {
      _earnedBadges.add("Crypto Curious");
    }

    // Badge for completing all modules (assuming there are around 10-15 modules)
    if (completedModulesCount >= 10 && !_earnedBadges.contains("Bitcoin Enthusiast")) {
      _earnedBadges.add("Bitcoin Enthusiast");
    }

    // Streak badges
    if (_currentStreak >= 3 && !_earnedBadges.contains("Consistent Learner")) {
      _earnedBadges.add("Consistent Learner");
    }

    if (_currentStreak >= 7 && !_earnedBadges.contains("Weekly Warrior")) {
      _earnedBadges.add("Weekly Warrior");
    }

    if (_currentStreak >= 30 && !_earnedBadges.contains("Monthly Master")) {
      _earnedBadges.add("Monthly Master");
    }

    // Level badges
    if (_level >= 5 && !_earnedBadges.contains("Block Explorer")) {
      _earnedBadges.add("Block Explorer");
    }

    if (_level >= 10 && !_earnedBadges.contains("Blockchain Veteran")) {
      _earnedBadges.add("Blockchain Veteran");
    }

    if (_level >= 20 && !_earnedBadges.contains("Crypto Grandmaster")) {
      _earnedBadges.add("Crypto Grandmaster");
    }
  }

  // For demo and testing
  void resetProgress() {
    _experiencePoints = 0;
    _level = 1;
    _completedModules.clear();
    _earnedBadges.clear();
    _currentStreak = 0;
    _bestStreak = 0;
    _dailyChallengeCompleted = false;
    _streakFreezesAvailable = 1;
    _hasLeveledUp = false;
    _lastCompletionDate = null;
    notifyListeners();
  }

  // Add streak freeze
  void addStreakFreeze() {
    _streakFreezesAvailable++;
    notifyListeners();
  }
}