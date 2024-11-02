class Task {
  final String id;
  final String title;
  bool isComplete;
  final DateTime date;

  Task({
    required this.id,
    required this.title,
    this.isComplete = false,
    required DateTime date,
  }) : date = DateTime(date.year, date.month, date.day);

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      isComplete: json['isComplete'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isComplete': isComplete,
      'date': date.toIso8601String(),
    };
  }
}
