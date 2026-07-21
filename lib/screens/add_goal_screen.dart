import 'package:flutter/material.dart';
import '../services/app_scope.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key, this.initialSkillId});

  final String? initialSkillId;

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  final title = TextEditingController();
  final target = TextEditingController(text: '10');
  String? skillId;

  @override
  void initState() {
    super.initState();
    skillId = widget.initialSkillId;
  }

  @override
  void dispose() {
    title.dispose();
    target.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    skillId ??=
        controller.skills.isNotEmpty ? controller.skills.first.id : null;

    return Scaffold(
      appBar: AppBar(title: const Text('New Goal')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DropdownButtonFormField<String>(
            value: skillId,
            decoration: const InputDecoration(labelText: 'Skill'),
            items: controller.skills
                .map(
                  (skill) => DropdownMenuItem(
                    value: skill.id,
                    child: Text(skill.name),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => skillId = value),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: title,
            decoration: const InputDecoration(labelText: 'Goal title'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: target,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Target count'),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: skillId == null
                ? null
                : () async {
                    final parsedTarget = int.tryParse(target.text) ?? 10;
                    await controller.addGoal(
                      skillId: skillId!,
                      title: title.text.trim().isEmpty
                          ? 'Practice Goal'
                          : title.text.trim(),
                      target: parsedTarget <= 0 ? 1 : parsedTarget,
                    );
                    if (context.mounted) Navigator.pop(context);
                  },
            child: const Text('Create Goal'),
          ),
        ],
      ),
    );
  }
}
