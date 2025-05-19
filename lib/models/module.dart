class Module {
  final int id;
  final String title;
  final String description;
  final String iconPath;
  final int pointsReward;
  final List<LessonContent> lessonContent;
  final List<Quiz> quizzes;
  final String badgeEarned;

  Module({
    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.pointsReward,
    required this.lessonContent,
    required this.quizzes,
    required this.badgeEarned,
  });
}

class LessonContent {
  final String title;
  final String content;
  final String? imagePath;

  LessonContent({
    required this.title,
    required this.content,
    this.imagePath,
  });
}

class Quiz {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  Quiz({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}