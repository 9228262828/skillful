import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/practice_session.dart';
import '../models/skill.dart';
import '../models/skill_goal.dart';

class AppController extends ChangeNotifier {
  AppController(this.prefs);

  final SharedPreferences prefs;
  final List<Skill> skills = [];
  final List<PracticeSession> sessions = [];
  final List<SkillGoal> goals = [];

  ThemeMode themeMode = ThemeMode.dark;
  String userName = 'Explorer';

  Future<void> load() async {
    themeMode =
        (prefs.getBool('darkMode') ?? true) ? ThemeMode.dark : ThemeMode.light;
    userName = prefs.getString('userName') ?? 'Explorer';

    skills
      ..clear()
      ..addAll(_readList('skills').map(Skill.fromJson));
    sessions
      ..clear()
      ..addAll(_readList('sessions').map(PracticeSession.fromJson));
    goals
      ..clear()
      ..addAll(_readList('goals').map(SkillGoal.fromJson));

    if (skills.isEmpty) {
      await addSkill(
        name: 'Digital Drawing',
        category: 'Drawing',
        description: 'Improve illustration and character design.',
        colorValue: const Color(0xFF14B8A6).value,
        targetMinutes: 1200,
      );
    }
  }

  List<Map<String, dynamic>> _readList(String key) {
    final raw = prefs.getString(key);
    if (raw == null || raw.isEmpty) return [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  String _id() => DateTime.now().microsecondsSinceEpoch.toString();

  Future<void> addSkill({
    required String name,
    required String category,
    required String description,
    required int colorValue,
    required int targetMinutes,
  }) async {
    skills.add(
      Skill(
        id: _id(),
        name: name,
        category: category,
        description: description,
        colorValue: colorValue,
        targetMinutes: targetMinutes,
        createdAt: DateTime.now(),
      ),
    );
    await _save();
    notifyListeners();
  }

  Future<void> deleteSkill(String id) async {
    skills.removeWhere((e) => e.id == id);
    sessions.removeWhere((e) => e.skillId == id);
    goals.removeWhere((e) => e.skillId == id);
    await _save();
    notifyListeners();
  }

  Future<void> addSession({
    required String skillId,
    required int minutes,
    required int rating,
    required String notes,
  }) async {
    sessions.add(
      PracticeSession(
        id: _id(),
        skillId: skillId,
        minutes: minutes,
        rating: rating,
        date: DateTime.now(),
        notes: notes,
      ),
    );
    await _save();
    notifyListeners();
  }

  Future<void> addGoal({
    required String skillId,
    required String title,
    required int target,
  }) async {
    goals.add(
      SkillGoal(
        id: _id(),
        skillId: skillId,
        title: title,
        target: target,
        progress: 0,
        createdAt: DateTime.now(),
      ),
    );
    await _save();
    notifyListeners();
  }

  Future<void> incrementGoal(String id) async {
    final index = goals.indexWhere((e) => e.id == id);
    if (index < 0) return;
    final goal = goals[index];
    goals[index] = goal.copyWith(
      progress: (goal.progress + 1).clamp(0, goal.target),
    );
    await _save();
    notifyListeners();
  }

  int minutesFor(String skillId) => sessions
      .where((e) => e.skillId == skillId)
      .fold<int>(0, (sum, e) => sum + e.minutes);

  int sessionsFor(String skillId) =>
      sessions.where((e) => e.skillId == skillId).length;

  int levelFor(String skillId) => (minutesFor(skillId) ~/ 120) + 1;

  double progressFor(Skill skill) =>
      (minutesFor(skill.id) / skill.targetMinutes).clamp(0, 1).toDouble();

  int get totalMinutes =>
      sessions.fold<int>(0, (sum, e) => sum + e.minutes);

  Future<void> setDarkMode(bool value) async {
    themeMode = value ? ThemeMode.dark : ThemeMode.light;
    await prefs.setBool('darkMode', value);
    notifyListeners();
  }

  Future<void> setUserName(String value) async {
    userName = value.trim().isEmpty ? 'Explorer' : value.trim();
    await prefs.setString('userName', userName);
    notifyListeners();
  }

  Future<void> resetData() async {
    skills.clear();
    sessions.clear();
    goals.clear();
    await _save();
    notifyListeners();
  }

  Future<void> _save() async {
    await prefs.setString(
      'skills',
      jsonEncode(skills.map((e) => e.toJson()).toList()),
    );
    await prefs.setString(
      'sessions',
      jsonEncode(sessions.map((e) => e.toJson()).toList()),
    );
    await prefs.setString(
      'goals',
      jsonEncode(goals.map((e) => e.toJson()).toList()),
    );
  }
}
