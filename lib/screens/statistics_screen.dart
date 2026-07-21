import 'package:flutter/material.dart';
import '../services/app_scope.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    final completed = controller.goals.where((e) => e.completed).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        childAspectRatio: 1.05,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        children: [
          _card(
            context,
            Icons.timer_outlined,
            '${controller.totalMinutes}',
            'Total Minutes',
          ),
          _card(
            context,
            Icons.auto_awesome_outlined,
            '${controller.skills.length}',
            'Active Skills',
          ),
          _card(
            context,
            Icons.play_circle_outline,
            '${controller.sessions.length}',
            'Sessions',
          ),
          _card(
            context,
            Icons.flag_outlined,
            '$completed',
            'Goals Done',
          ),
        ],
      ),
    );
  }

  Widget _card(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
