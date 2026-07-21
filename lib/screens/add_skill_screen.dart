import 'package:flutter/material.dart';
import '../core/app_constants.dart';
import '../services/app_scope.dart';

class AddSkillScreen extends StatefulWidget {
  const AddSkillScreen({super.key});

  @override
  State<AddSkillScreen> createState() => _AddSkillScreenState();
}

class _AddSkillScreenState extends State<AddSkillScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final description = TextEditingController();
  final target = TextEditingController(text: '600');
  String category = AppConstants.categories.first;
  int colorIndex = 0;

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    target.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Skill')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Skill name'),
              validator: (value) =>
                  value == null || value.trim().isEmpty
                      ? 'Enter a skill name'
                      : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: category,
              decoration: const InputDecoration(labelText: 'Category'),
              items: AppConstants.categories
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => category = value!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: description,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: target,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Target minutes'),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(
                AppConstants.colors.length,
                (index) => GestureDetector(
                  onTap: () => setState(() => colorIndex = index),
                  child: CircleAvatar(
                    backgroundColor: AppConstants.colors[index],
                    child: colorIndex == index
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            FilledButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                await AppScope.of(context).addSkill(
                  name: name.text.trim(),
                  category: category,
                  description: description.text.trim(),
                  colorValue: AppConstants.colors[colorIndex].value,
                  targetMinutes: int.tryParse(target.text) ?? 600,
                );
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Create Skill'),
            ),
          ],
        ),
      ),
    );
  }
}
