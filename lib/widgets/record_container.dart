import 'package:flutter/material.dart';
import 'package:honomara/models/record.dart';

class RecordContainer extends StatelessWidget{
  const RecordContainer({
    super.key,
    required this.record,
    required this.index,
    required this.isPB,
  });

  final Record record;
  final int index;
  final bool isPB;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: isPB ? Colors.amber[100] : (index % 2 == 0 ?Colors.transparent: Colors.blue[50]),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.date,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  record.event,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ]
            ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isPB ? "PB" : "",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold
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