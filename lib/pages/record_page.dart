import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:honomara/components/grade_chip.dart';
import 'package:honomara/models/event.dart';
import 'package:honomara/models/rank.dart';
import 'package:honomara/utils/date_utils.dart';
import 'package:honomara/utils/time_utils.dart';
import 'package:honomara/widgets/event_container.dart';
import 'package:honomara/widgets/rank_container.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> with TickerProviderStateMixin {
  List<Event> events = [];
  List<Rank> ranks = [];
  late TabController _tabController;
  List<String> selectedGrade = ['27期', "28期", "29期", "30期", "31期", "32期", "33期"];
  List<Rank> display = [];

  Future<void> getData() async {
    // コレクションからデータを取得
    CollectionReference collection =
        FirebaseFirestore.instance.collection('events');
    QuerySnapshot querySnapshot = await collection.get();

    // データを処理
    List<Event> fetchedEvents = querySnapshot.docs
        .map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    fetchedEvents.sort((a, b) {
      DateTime aDate = parseDateString(a.date);
      DateTime bDate = parseDateString(b.date);
      return -1 * aDate.compareTo(bDate);
    });

    setState(() {
      events = fetchedEvents;
    });
  }

  Future<void> rankData() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('runners');
    QuerySnapshot querySnapshot = await collection.get();

    List<Rank> fetchedRanks = querySnapshot.docs
        .map((doc) => Rank.fromJson(doc.data() as Map<String, dynamic>))
        .where((rank) => rank.time.isNotEmpty)
        .toList();

    // JSONデータをtime降順でソート
    fetchedRanks.sort((a, b) {
      int aTime = parseTimeString(a.time);
      int bTime = parseTimeString(b.time);
      return aTime.compareTo(bTime);
    });

    setState(() {
      ranks = fetchedRanks;
      display = ranks;
    });
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
        title: const Text('フルマラソンの記録'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
        bottom: TabBar(controller: _tabController, tabs: const [
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
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
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
                      return Container(
                        height: 20,
                        color: Colors.pink[50],
                      ); // 余白の高さを指定
                    }
                    final event = events[index];
                    return EventContainer(event: event);
                  },
                ),
              ),
            ),
          ]),
          Column(children: [
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
            Wrap(spacing: 10, children: [
              GradeFilterChip(
                grade: "27期",
                selectedGrade: selectedGrade,
                onSelectionChanged: (newSelectedGrade) {
                  setState(() {
                    selectedGrade = newSelectedGrade;
                    display = selectGrade();
                  });
                },
              ),
              GradeFilterChip(
                grade: "28期",
                selectedGrade: selectedGrade,
                onSelectionChanged: (newSelectedGrade) {
                  setState(() {
                    selectedGrade = newSelectedGrade;
                    display = selectGrade();
                  });
                },
              ),
              GradeFilterChip(
                grade: "29期",
                selectedGrade: selectedGrade,
                onSelectionChanged: (newSelectedGrade) {
                  setState(() {
                    selectedGrade = newSelectedGrade;
                    display = selectGrade();
                  });
                },
              ),
              GradeFilterChip(
                grade: "30期",
                selectedGrade: selectedGrade,
                onSelectionChanged: (newSelectedGrade) {
                  setState(() {
                    selectedGrade = newSelectedGrade;
                    display = selectGrade();
                  });
                },
              ),
              GradeFilterChip(
                grade: "31期",
                selectedGrade: selectedGrade,
                onSelectionChanged: (newSelectedGrade) {
                  setState(() {
                    selectedGrade = newSelectedGrade;
                    display = selectGrade();
                  });
                },
              ),
              GradeFilterChip(
                grade: "32期",
                selectedGrade: selectedGrade,
                onSelectionChanged: (newSelectedGrade) {
                  setState(() {
                    selectedGrade = newSelectedGrade;
                    display = selectGrade();
                  });
                },
              ),
              GradeFilterChip(
                grade: "33期",
                selectedGrade: selectedGrade,
                onSelectionChanged: (newSelectedGrade) {
                  setState(() {
                    selectedGrade = newSelectedGrade;
                    display = selectGrade();
                  });
                },
              ),
            ]),
            Expanded(
              child: Scrollbar(
                thickness: 8.0,
                radius: const Radius.circular(4.0),
                // thumbVisibility: true,
                child: ListView.builder(
                  itemCount: display.length + 1,
                  itemBuilder: (context, index) {
                    if (index == display.length) {
                      return Container(
                        height: 20,
                        color: Colors.pink[50],
                      ); // 余白の高さを指定
                    }
                    final rank = display[index];
                    return RankContainer(
                      rank: rank,
                      index: index,
                    );
                  },
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
