class Task {
  String title;
  bool isComplete;

  Task({required this.title, this.isComplete = false});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isComplete': isComplete,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      isComplete: json['isComplete'],
    );
  }
}
