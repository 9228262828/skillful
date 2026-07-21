import 'package:flutter/material.dart';
import '../core/app_constants.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const String policyText = '''
Last updated: July 21, 2026

Skillful is an offline skill and practice tracking application.

Information You Enter
You may enter skill names, categories, goals, practice durations, ratings, and notes.

Local Storage
Your information is stored locally on your device using application storage.

Data Collection
Skillful does not require an account and does not collect, sell, rent, or share your personal information.

Third-Party Services
The current version does not use advertising, analytics, cloud storage, third-party authentication, or developer-operated servers.

Permissions
Skillful does not require sensitive device permissions for its main features.

Data Retention and Deletion
Your records remain on your device until you remove them, reset app data, clear app storage, or uninstall the app.

Security
The security of your data depends partly on the security of your device. Use a screen lock and keep your operating system updated.

Children
Skillful is a general productivity application and is not specifically directed to children under 13.

Changes
This policy may be updated when the app or its privacy practices change.

Contact
For privacy questions, contact:
''';

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(title: Text('Privacy Policy')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(22),
        child: Text(
          policyText + AppConstants.contactEmail,
          style: TextStyle(fontSize: 16, height: 1.7),
        ),
      ),
    );
  }
}
