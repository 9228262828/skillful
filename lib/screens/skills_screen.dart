import 'package:flutter/material.dart';
import '../services/app_scope.dart';
import '../widgets/empty_state.dart';
import '../widgets/skill_card.dart';
import 'add_skill_screen.dart';
import 'skill_details_screen.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Skills')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddSkillScreen()),
        ),
        child: const Icon(Icons.add),
      ),
      body: controller.skills.isEmpty
          ? const EmptyState(
              icon: Icons.auto_awesome_outlined,
              title: 'No skills yet',
              message: 'Create your first skill and start your journey.',
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
              itemCount: controller.skills.length,
              itemBuilder: (_, index) {
                final skill = controller.skills[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SkillCard(
                    skill: skill,
                    level: controller.levelFor(skill.id),
                    minutes: controller.minutesFor(skill.id),
                    progress: controller.progressFor(skill),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            SkillDetailsScreen(skillId: skill.id),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
