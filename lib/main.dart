import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/app_theme.dart';
import 'screens/splash_screen.dart';
import 'services/app_controller.dart';
import 'services/app_scope.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final controller = AppController(prefs);
  await controller.load();
  runApp(SkillfulApp(controller: controller));
}

class SkillfulApp extends StatelessWidget {
  const SkillfulApp({super.key, required this.controller});
  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return AppScope(
      controller: controller,
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Skillful',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: controller.themeMode,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
