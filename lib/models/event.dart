import 'package:honomara/models/runner.dart';

class Event {
  Event({
    required this.name,
    required this.date,
    this.runners = const [],
  });

  final String name;
  final String date;
  final List<Runner> runners;

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'] as String,
      date: json['date'] as String,
      runners: List<Runner>.from(json['runners'].map((runner) => Runner.fromJson(runner))),
    );
  }
}