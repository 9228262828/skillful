class Skill {
  const Skill({
    required this.id,
    required this.name,
    required this.category,
    required this.colorValue,
    required this.createdAt,
    this.description = '',
    this.targetMinutes = 600,
  });

  final String id;
  final String name;
  final String category;
  final String description;
  final int colorValue;
  final int targetMinutes;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'description': description,
        'colorValue': colorValue,
        'targetMinutes': targetMinutes,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        id: json['id'] as String,
        name: json['name'] as String,
        category: json['category'] as String,
        description: (json['description'] ?? '') as String,
        colorValue: json['colorValue'] as int,
        targetMinutes: (json['targetMinutes'] ?? 600) as int,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}
