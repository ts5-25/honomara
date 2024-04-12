import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:honomara/models/event.dart';
import 'package:honomara/models/rank.dart';
import 'package:honomara/widgets/event_container.dart';
import 'package:honomara/widgets/rank_container.dart';
import 'package:flutter/services.dart' show rootBundle;

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> with TickerProviderStateMixin {
  List<Event> events = [];
  List<Rank> ranks = [];
  late TabController _tabController;

  Future<void> getData() async {
    final jsonData = await rootBundle.loadString('json/data.json');
    final Map<String, dynamic> decodedData = jsonDecode(jsonData);
    final List<dynamic> eventData = decodedData['event'];
    events = eventData.map((json) => Event.fromJson(json)).toList();
    setState(() {});
  }

  Future<void> rankData() async {
    final jsonData = await rootBundle.loadString('json/ranking.json');
    final List<dynamic> decodedData = jsonDecode(jsonData);
    // JSONデータをtime降順でソート
    decodedData.sort((a, b) {
      int aTime = _parseTimeString(a['time'] as String);
      int bTime = _parseTimeString(b['time'] as String);
      return aTime.compareTo(bTime);
    });
    ranks = decodedData.map((json) => Rank.fromJson(json)).toList();
    setState(() {});
  }

  int _parseTimeString(String timeString) {
    List<String> parts = timeString.split(':');
    if (parts.length != 3) {
      return 0; // 不正な時間文字列の場合は0を返す
    }
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);
    return hours * 3600 + minutes * 60 + seconds;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getData();
    rankData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ホノマラ フルマラソンの記録'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text(
                          "大会の記録",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            //fontWeight: FontWeight.bold 
                          ),
                        ),
            ),
            Tab(
              child: Text(
                          "ランキング",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            //fontWeight: FontWeight.bold 
                          ),
                        ),
            )
          ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Scrollbar(
                thickness: 8.0,
                radius: const Radius.circular(4.0),
                // thumbVisibility: true,
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return EventContainer(event: event);
                  },
                ),
              ),
            
          ),
          Center(
            child: Scrollbar(
                thickness: 8.0,
                radius: const Radius.circular(4.0),
                // thumbVisibility: true,
                child: ListView.builder(
                  itemCount: ranks.length,
                  itemBuilder: (context, index) {
                    final rank = ranks[index];
                    return RankContainer(rank: rank, index: index,);
                  },
                ),
              ),
            
          ),
        ],
      ),    
    );
  }
}