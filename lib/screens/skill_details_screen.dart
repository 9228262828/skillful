import 'package:flutter/material.dart';
import '../services/app_scope.dart';
import 'add_goal_screen.dart';
import 'add_session_screen.dart';

class SkillDetailsScreen extends StatelessWidget {
  const SkillDetailsScreen({super.key, required this.skillId});

  final String skillId;

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    final skill = controller.skills.firstWhere((e) => e.id == skillId);
    final color = Color(skill.colorValue);
    final sessions = controller.sessions
        .where((e) => e.skillId == skillId)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      appBar: AppBar(
        title: Text(skill.name),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.deleteSkill(skill.id);
              if (context.mounted) Navigator.pop(context);
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                colors: [color, color.withOpacity(.55)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Level ${controller.levelFor(skill.id)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${controller.minutesFor(skill.id)} minutes practiced',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 18),
                LinearProgressIndicator(
                  value: controller.progressFor(skill),
                  minHeight: 9,
                  borderRadius: BorderRadius.circular(99),
                  color: Colors.white,
                  backgroundColor: Colors.white24,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          AddSessionScreen(initialSkillId: skill.id),
                    ),
                  ),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Practice'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddGoalScreen(
                        initialSkillId: skill.id,
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.flag_outlined),
                  label: const Text('Goal'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            'Recent Sessions',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          if (sessions.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text('No practice sessions yet.'),
              ),
            ),
          ...sessions.map(
            (session) => Card(
              child: ListTile(
                leading: const Icon(Icons.timer_outlined),
                title: Text('${session.minutes} minutes'),
                subtitle: Text(
                  session.notes.isEmpty
                      ? '${session.date.day}/${session.date.month}/${session.date.year}'
                      : session.notes,
                ),
                trailing: Text('⭐ ${session.rating}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
