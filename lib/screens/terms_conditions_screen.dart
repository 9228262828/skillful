import 'package:flutter/material.dart';
import '../core/app_constants.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  static const String termsText = '''
Last updated: July 21, 2026

By downloading or using Skillful, you agree to these Terms and Conditions.

Purpose
Skillful is a personal productivity tool for tracking skills, goals, practice sessions, progress, and achievements.

User Responsibility
You are responsible for the information you enter and for protecting access to your device.

No Professional Advice
Skillful does not provide educational certification, professional coaching, medical advice, financial advice, or guaranteed learning results.

Estimated Progress
Levels, progress indicators, achievements, and statistics are motivational tools based on the information you enter. They are not professional assessments.

Availability
Features may be improved, modified, suspended, or discontinued.

Disclaimer
The application is provided as is and as available without guarantees of uninterrupted or error-free operation.

Local Data
Important information should be backed up separately. Local data may be lost if the app is deleted, device storage is cleared, or the device is damaged.

Limitation of Liability
To the maximum extent permitted by law, the developer is not responsible for indirect losses, data loss, or decisions based on information shown in the app.

Changes
These terms may be updated when the app changes.

Contact
For questions, contact:
''';

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(title: Text('Terms & Conditions')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(22),
        child: Text(
          termsText + AppConstants.contactEmail,
          style: TextStyle(fontSize: 16, height: 1.7),
        ),
      ),
    );
  }
}
