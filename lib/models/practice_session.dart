class PracticeSession {
  const PracticeSession({
    required this.id,
    required this.skillId,
    required this.minutes,
    required this.rating,
    required this.date,
    this.notes = '',
  });

  final String id;
  final String skillId;
  final int minutes;
  final int rating;
  final DateTime date;
  final String notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'skillId': skillId,
        'minutes': minutes,
        'rating': rating,
        'date': date.toIso8601String(),
        'notes': notes,
      };

  factory PracticeSession.fromJson(Map<String, dynamic> json) =>
      PracticeSession(
        id: json['id'] as String,
        skillId: json['skillId'] as String,
        minutes: json['minutes'] as int,
        rating: (json['rating'] ?? 3) as int,
        date: DateTime.parse(json['date'] as String),
        notes: (json['notes'] ?? '') as String,
      );
}
