class Record {
  Record({
    required this.date,
    required this.event,
    required this.time,
  });

  final String date;
  final String event;
  final String time;

  factory Record.fromJson(dynamic json) {
    return Record(
      date: json['name'] as String,
      event: json['grade'] as String,
      time: json['time'] as String,
    );
  }
}