import 'package:flutter/material.dart';
import '../services/app_scope.dart';
import '../widgets/skill_card.dart';
import 'add_session_screen.dart';
import 'settings_screen.dart';
import 'skill_details_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, ${controller.userName} 👋'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      floatingActionButton: controller.skills.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddSessionScreen()),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Practice'),
            ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                colors: [Color(0xFF5B3DF5), Color(0xFF0EA5A8)],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _metric(
                  '${(controller.totalMinutes / 60).toStringAsFixed(1)}h',
                  'Practice',
                ),
                _metric('${controller.skills.length}', 'Skills'),
                _metric('${controller.goals.length}', 'Goals'),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Your Skills',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          ...controller.skills.map(
            (skill) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SkillCard(
                skill: skill,
                level: controller.levelFor(skill.id),
                minutes: controller.minutesFor(skill.id),
                progress: controller.progressFor(skill),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SkillDetailsScreen(skillId: skill.id),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metric(String value, String label) => Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(label, style: const TextStyle(color: Colors.white70)),
        ],
      );
}
