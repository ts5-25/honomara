class Rank {
  Rank({
    required this.name,
    required this.grade,
    required this.date,
    required this.event,
    required this.time,
  });

  final String name;
  final String grade;
  final String date;
  final String event;
  final String time;

  factory Rank.fromJson(dynamic json) {
    return Rank(
      name: json['name'] as String,
      grade: json['grade'] as String,
      date: json['date'] as String,
      event: json['event'] as String,
      time: json['time'] as String,
    );
  }
}