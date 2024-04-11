import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:honomara/models/event.dart';
import 'package:honomara/widgets/event_container.dart';
import 'package:flutter/services.dart' show rootBundle;

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
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
  Widget build(BuildContext content) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ホノマラ  フルマラソンの記録'),
      ),
      body: Scrollbar(
        thickness: 8.0, // スクロールバーの幅を8pxに変更
        radius: const Radius.circular(4.0), // スクロールバーの角丸を4pxに変更
        thumbVisibility: true,
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return EventContainer(event: event);
          },
        ),
      ),
    );
  }
}

