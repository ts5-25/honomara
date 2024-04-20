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
  List<String> selectedGrade = ["28期", "29期", "30期", "31期"];
  List<Rank> display = [];

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
    display = ranks;
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

  List<Rank> selectGrade() {
    final List<Rank> sortRanks = [];
    for (Rank rank in ranks) {
      if (selectedGrade.contains(rank.grade)) {
        sortRanks.add(rank);
      }
    }
    return sortRanks;
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                color: Colors.pink[50],
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: const Text(
                "※記録は全てネットタイム",
                textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black, 
                          ),
                ),
              ),
              Expanded(
                child: Scrollbar(
                  thickness: 8.0,
                  radius: const Radius.circular(4.0),
                  // thumbVisibility: true,
                  child: ListView.builder(
                    itemCount: events.length + 1,
                    itemBuilder: (context, index) {
                      if (index == events.length) { 
                        return Container(height: 20, color: Colors.pink[50],); // 余白の高さを指定
                      }
                      final event = events[index];
                      return EventContainer(event: event);
                    },
                  ),
                ),
              ),
            ]
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.pink[50],
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: const Text(
                "※記録は全てネットタイム",
                textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black, 
                          ),
                ),
              ),
              Wrap(
                spacing: 10,
                children: [
                  FilterChip(
                    label: Text(
                      "28期",
                      style: TextStyle(
                            color: selectedGrade.contains("28期")? Colors.white: Colors.grey[600], 
                          ),
                    ),
                    backgroundColor: Colors.white,
                    selectedColor: Colors.grey[600],
                    showCheckmark: false,
                    selected: selectedGrade.contains("28期"),
                    onSelected: (bool value) {
                      setState(() {
                        if (value) {
                          if (!selectedGrade.contains("28期")) {
                            selectedGrade.add("28期");
                          }
                        } else {
                          selectedGrade.removeWhere((filterFilter) => filterFilter == "28期");
                        }
                        display = selectGrade();
                      });
                    },
                  ),
                  FilterChip(
                    label: Text(
                      "29期",
                      style: TextStyle(
                            color: selectedGrade.contains("29期")? Colors.white: Colors.grey[600], 
                          ),
                    ),
                    backgroundColor: Colors.white,
                    selectedColor: Colors.grey[600],
                    showCheckmark: false,
                    selected: selectedGrade.contains("29期"),
                    onSelected: (bool value) {
                      setState(() {
                        if (value) {
                          if (!selectedGrade.contains("29期")) {
                            selectedGrade.add("29期");
                          }
                        } else {
                          selectedGrade.removeWhere((filterFilter) => filterFilter == "29期");
                        }
                        display = selectGrade();
                      });
                    },
                  ),
                  FilterChip(
                    label: Text(
                      "30期",
                      style: TextStyle(
                            color: selectedGrade.contains("30期")? Colors.white: Colors.grey[600], 
                          ),
                    ),
                    backgroundColor: Colors.white,
                    selectedColor: Colors.grey[600],
                    showCheckmark: false,
                    selected: selectedGrade.contains("30期"),
                    onSelected: (bool value) {
                      setState(() {
                        if (value) {
                          if (!selectedGrade.contains("30期")) {
                            selectedGrade.add("30期");
                          }
                        } else {
                          selectedGrade.removeWhere((filterFilter) => filterFilter == "30期");
                        }
                        display = selectGrade();
                      });
                    },
                  ),
                  FilterChip(
                    label: Text(
                      "31期",
                      style: TextStyle(
                            color: selectedGrade.contains("31期")? Colors.white: Colors.grey[600], 
                          ),
                    ),
                    backgroundColor: Colors.white,
                    selectedColor: Colors.grey[600],
                    showCheckmark: false,
                    selected: selectedGrade.contains("31期"),
                    onSelected: (bool value) {
                      setState(() {
                        if (value) {
                          if (!selectedGrade.contains("31期")) {
                            selectedGrade.add("31期");
                          }
                        } else {
                          selectedGrade.removeWhere((filterFilter) => filterFilter == "31期");
                        }
                        display = selectGrade();
                      });
                    },
                  ),
                ]
              ),
              Expanded(
                child: Scrollbar(
                  thickness: 8.0,
                  radius: const Radius.circular(4.0),
                  // thumbVisibility: true,
                  child: ListView.builder(
                    itemCount: display.length + 1,
                    itemBuilder: (context, index) {
                      if (index == display.length) { 
                        return Container(height: 20, color: Colors.pink[50],); // 余白の高さを指定
                      }
                      final rank = display[index];
                      return RankContainer(rank: rank, index: index,);
                    },
                  ),
                ),
              ),
            ]
          ),
        ],
      ),    
    );
  }
}