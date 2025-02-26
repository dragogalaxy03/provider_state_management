class Task {
  String title;
  bool isCompleted;
  String priority; // High, Medium, Low
  DateTime dueDate;

  Task({
    required this.title,
    this.isCompleted = false,
    required this.priority,
    required this.dueDate,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'isCompleted': isCompleted,
    'priority': priority,
    'dueDate': dueDate.toIso8601String(),
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json['title'],
    isCompleted: json['isCompleted'],
    priority: json['priority'],
    dueDate: DateTime.parse(json['dueDate']),
  );
}
