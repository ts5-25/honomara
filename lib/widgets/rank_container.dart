import 'package:flutter/material.dart';
import 'package:honomara/models/rank.dart';
import 'package:honomara/pages/personal_page.dart';

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
    return Column(
          children: [
            GestureDetector(
              onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => PersonalPage(name: rank.name, grade: rank.grade, pb: rank.time,)),
                        ),
                      ); // Containerをタップした時の処理
                    },
            child: 
            Container(
              color: Colors.pink[50],
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 6,
              ),
              child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  (index + 1).toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Text(
                  rank.name,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Text(
                  rank.grade,
                  style: const TextStyle(
                    fontSize: 16,
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
            ),
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 20,
                bottom: 10,
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  rank.date,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  rank.event,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ]
            ),
            ),
          ],

    );
  }
}