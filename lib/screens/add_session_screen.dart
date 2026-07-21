import 'package:flutter/material.dart';
import '../services/app_scope.dart';

class AddSessionScreen extends StatefulWidget {
  const AddSessionScreen({super.key, this.initialSkillId});

  final String? initialSkillId;

  @override
  State<AddSessionScreen> createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  final minutes = TextEditingController(text: '30');
  final notes = TextEditingController();
  String? skillId;
  int rating = 4;

  @override
  void initState() {
    super.initState();
    skillId = widget.initialSkillId;
  }

  @override
  void dispose() {
    minutes.dispose();
    notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    skillId ??=
        controller.skills.isNotEmpty ? controller.skills.first.id : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Log Practice')),
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
            controller: minutes,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Duration in minutes',
            ),
          ),
          const SizedBox(height: 18),
          Text('Rating: $rating stars'),
          Slider(
            value: rating.toDouble(),
            min: 1,
            max: 5,
            divisions: 4,
            onChanged: (value) => setState(() => rating = value.round()),
          ),
          TextField(
            controller: notes,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'Session notes'),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: skillId == null
                ? null
                : () async {
                    final duration = int.tryParse(minutes.text) ?? 30;
                    await controller.addSession(
                      skillId: skillId!,
                      minutes: duration <= 0 ? 1 : duration,
                      rating: rating,
                      notes: notes.text.trim(),
                    );
                    if (context.mounted) Navigator.pop(context);
                  },
            child: const Text('Save Session'),
          ),
        ],
      ),
    );
  }
}
