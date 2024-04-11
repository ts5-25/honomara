import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:honomara/models/rank.dart';
import 'package:honomara/widgets/rank_container.dart';
import 'package:flutter/services.dart' show rootBundle;

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  List<Rank> ranks = [];

  Future<void> getData() async {
    final jsonData = await rootBundle.loadString('json/ranking.json');
    final List<dynamic> decodedData = jsonDecode(jsonData);
    // JSONデータをtime降順でソート
  decodedData.sort((a, b) => (b['time'] as num).compareTo(a['time'] as num));
  ranks = decodedData.map((json) => Rank.fromJson(json)).toList();
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
          itemCount: ranks.length,
          itemBuilder: (context, index) {
            final rank = ranks[index];
            return RankContainer(rank: rank, index: index,);
          },
        ),
      ),
    );
  }
}

