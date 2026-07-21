import 'package:flutter/material.dart';
import '../core/app_constants.dart';
import '../services/app_scope.dart';
import 'privacy_policy_screen.dart';
import 'terms_conditions_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Use the dark Skillful theme'),
            value: controller.themeMode == ThemeMode.dark,
            onChanged: controller.setDarkMode,
          ),
          ListTile(
            title: const Text('Profile name'),
            subtitle: Text(controller.userName),
            trailing: const Icon(Icons.edit_outlined),
            onTap: () async {
              final text = TextEditingController(text: controller.userName);
              final result = await showDialog<String>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Profile name'),
                  content: TextField(controller: text),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(context, text.text),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              );
              text.dispose();
              if (result != null) {
                await controller.setUserName(result);
              }
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PrivacyPolicyScreen(),
              ),
            ),
          ),
          ListTile(
            title: const Text('Terms & Conditions'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const TermsConditionsScreen(),
              ),
            ),
          ),
          const ListTile(
            title: Text('App Version'),
            subtitle: Text(AppConstants.appVersion),
          ),
          const Divider(),
          ListTile(
            textColor: Theme.of(context).colorScheme.error,
            iconColor: Theme.of(context).colorScheme.error,
            leading: const Icon(Icons.delete_outline),
            title: const Text('Reset all data'),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Reset all data?'),
                  content: const Text(
                    'This will permanently remove all skills, sessions, and goals from this device.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await controller.resetData();
              }
            },
          ),
        ],
      ),
    );
  }
}
