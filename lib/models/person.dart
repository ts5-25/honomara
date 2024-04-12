import 'package:honomara/models/record.dart';

class Person {
  Person({
    required this.name,
    required this.grade,
    this.pb = "",
    this.records = const [], 
  });

  final String name;
  final String grade;
  final String? pb;
  final List<Record> records;

  factory Person.fromJson(String name, String grade, String pb, dynamic json) {
    final List<Record> list = [];
    for (final event in json) {
      for (final runner in event['runners']) {
        if (runner['name'] == name) {
          list.add(Record(date: event['date'], event: event['name'], time: runner['time']));
        }
      }
    }
    return Person(
      name: name,
      grade: grade,
      pb: pb,
      records: list, 
    );
  }
}