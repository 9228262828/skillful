import 'package:flutter/material.dart';
import '../services/app_scope.dart';
import '../widgets/empty_state.dart';
import 'add_goal_screen.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Goals')),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.skills.isEmpty
            ? null
            : () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddGoalScreen()),
                ),
        child: const Icon(Icons.add),
      ),
      body: controller.goals.isEmpty
          ? const EmptyState(
              icon: Icons.flag_outlined,
              title: 'No goals yet',
              message: 'Create a measurable goal for one of your skills.',
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
              children: controller.goals.map((goal) {
                String skillName = 'Unknown skill';
                for (final skill in controller.skills) {
                  if (skill.id == goal.skillId) {
                    skillName = skill.name;
                    break;
                  }
                }

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          goal.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(skillName),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: goal.percentage,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text('${goal.progress}/${goal.target}'),
                            const Spacer(),
                            IconButton(
                              onPressed: goal.completed
                                  ? null
                                  : () =>
                                      controller.incrementGoal(goal.id),
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
