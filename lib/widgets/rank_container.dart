import 'package:flutter/material.dart';
import 'package:honomara/models/rank.dart';

class RankContainer extends StatelessWidget{
  const RankContainer({
    super.key,
    required this.rank,
    required this.index,
  });

  final Rank rank;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: index % 2 == 0 ?Colors.transparent: Colors.pink.shade50,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rank.name,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  rank.event,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Text(
                  rank.time,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ]
            ),
          ],
        ),
    );
  }
}