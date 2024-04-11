import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:honomara/models/event.dart';
import 'package:honomara/widgets/event_container.dart';
import 'package:flutter/services.dart' show rootBundle;

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  List<Event> events = [];

  Future<void> getData() async {
    final jsonData = await rootBundle.loadString('json/data.json');
    final Map<String, dynamic> decodedData = jsonDecode(jsonData);
    final List<dynamic> eventData = decodedData['event'];
    events = eventData.map((json) => Event.fromJson(json)).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ホノマラ フルマラソンの記録'),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: 
                Text(
                  "大会記録",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    //fontWeight: FontWeight.bold 
                  ),
                ),
                ),
                Expanded(
                  child: 
                
                Text(
                  "ランキング",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Scrollbar(
              thickness: 8.0,
              radius: const Radius.circular(4.0),
              thumbVisibility: true,
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return EventContainer(event: event);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}