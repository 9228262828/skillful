import 'package:flutter/material.dart';
import '../services/app_scope.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);

    final badges = [
      _Badge(
        'First Step',
        'Complete your first session',
        controller.sessions.isNotEmpty,
      ),
      _Badge(
        'Focused',
        'Complete 5 sessions',
        controller.sessions.length >= 5,
      ),
      _Badge(
        'Dedicated',
        'Practice for 5 hours',
        controller.totalMinutes >= 300,
      ),
      _Badge(
        'Skill Builder',
        'Create 3 skills',
        controller.skills.length >= 3,
      ),
      _Badge(
        'Goal Crusher',
        'Complete your first goal',
        controller.goals.any((e) => e.completed),
      ),
      _Badge(
        'Master',
        'Practice for 20 hours',
        controller.totalMinutes >= 1200,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Achievements')),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: .9,
        ),
        itemCount: badges.length,
        itemBuilder: (_, index) {
          final badge = badges[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    badge.unlocked
                        ? Icons.emoji_events_rounded
                        : Icons.lock_outline,
                    size: 48,
                    color: badge.unlocked
                        ? Colors.amber
                        : Theme.of(context).disabledColor,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    badge.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    badge.description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Badge {
  const _Badge(this.title, this.description, this.unlocked);

  final String title;
  final String description;
  final bool unlocked;
}
