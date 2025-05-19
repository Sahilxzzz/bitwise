import 'package:flutter/material.dart';
import '../models/module.dart';
import 'lesson_screen.dart';

class ModuleDetailScreen extends StatelessWidget {
  final Module module;

  const ModuleDetailScreen({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(module.title,style: TextStyle(color: Colors.amber),),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    module.description,
    style: Theme.of(context).textTheme.bodyLarge,
    ),
    const SizedBox(height: 24),
    Text(
    'Lessons',
    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 22),
    ),
    const SizedBox(height: 16),
    Expanded(
    child: ListView.builder(
    itemCount: module.lessonContent.length,
    itemBuilder: (context, index) {
    return _buildLessonCard(context, index);
    },
    ),
    ),
    const SizedBox(height: 16),
    Center(
    child: ElevatedButton(
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => LessonScreen(module: module),
    ),
    );
    },
    child: const Text(
    'Start Module',
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    ),
    const SizedBox(height: 16),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    const Icon(Icons.emoji_events, color: Colors.amber),
    const SizedBox(width: 8),
    Text(
      'Complete this module to earn "${module.badgeEarned}" badge',
      style: const TextStyle(color: Colors.amber),
    ),
    ],
    ),
    ],
    ),
        ),
    );
  }

  Widget _buildLessonCard(BuildContext context, int index) {
    final lesson = module.lessonContent[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  lesson.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}