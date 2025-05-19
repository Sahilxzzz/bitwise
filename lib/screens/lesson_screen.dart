import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/module.dart';
import '../models/user_progress.dart';
import 'quiz_screen.dart';

class LessonScreen extends StatefulWidget {
  final Module module;

  const LessonScreen({super.key, required this.module});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _currentLessonIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.module.title),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress indicator
          LinearProgressIndicator(
            value: (_currentLessonIndex + 1) / widget.module.lessonContent.length,
            backgroundColor: Colors.grey[800],
            color: Theme.of(context).primaryColor,
            minHeight: 6,
          ),

          // Lesson content
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentLessonIndex = index;
                });
              },
              children: widget.module.lessonContent.map((lesson) {
                return _buildLessonContent(lesson);
              }).toList(),
            ),
          ),

          // Navigation buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentLessonIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                    ),
                    child: const Text('Previous'),
                  )
                else
                  const SizedBox(width: 100),

                ElevatedButton(
                  onPressed: () {
                    if (_currentLessonIndex < widget.module.lessonContent.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // Navigate to quiz screen when all lessons are completed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(module: widget.module),
                        ),
                      );
                    }
                  },
                  child: Text(
                    _currentLessonIndex < widget.module.lessonContent.length - 1
                        ? 'Next'
                        : 'Take Quiz',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonContent(LessonContent lesson) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lesson.title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          if (lesson.imagePath != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  lesson.imagePath!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Text(
            lesson.content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
