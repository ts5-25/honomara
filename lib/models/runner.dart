class Runner {
  Runner({
    required this.name,
    required this.grade,
    required this.time,
  });

  final String name;
  final String grade;
  final String time;

  factory Runner.fromJson(dynamic json) {
    return Runner(
      name: json['name'] as String,
      grade: json['grade'] as String,
      time: json['time'] as String,
    );
  }
}