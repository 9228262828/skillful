class SkillGoal {
  const SkillGoal({
    required this.id,
    required this.skillId,
    required this.title,
    required this.target,
    required this.progress,
    required this.createdAt,
  });

  final String id;
  final String skillId;
  final String title;
  final int target;
  final int progress;
  final DateTime createdAt;

  bool get completed => progress >= target;

  double get percentage =>
      target <= 0 ? 0 : (progress / target).clamp(0, 1).toDouble();

  SkillGoal copyWith({int? progress}) => SkillGoal(
        id: id,
        skillId: skillId,
        title: title,
        target: target,
        progress: progress ?? this.progress,
        createdAt: createdAt,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'skillId': skillId,
        'title': title,
        'target': target,
        'progress': progress,
        'createdAt': createdAt.toIso8601String(),
      };

  factory SkillGoal.fromJson(Map<String, dynamic> json) => SkillGoal(
        id: json['id'] as String,
        skillId: json['skillId'] as String,
        title: json['title'] as String,
        target: json['target'] as int,
        progress: (json['progress'] ?? 0) as int,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}
