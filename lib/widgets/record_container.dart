import 'package:flutter/material.dart';
import 'package:honomara/models/record.dart';

class RecordContainer extends StatelessWidget{
  const RecordContainer({
    super.key,
    required this.record,
    required this.index,
  });

  final Record record;
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
              record.date,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  record.event,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Text(
                  record.time,
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