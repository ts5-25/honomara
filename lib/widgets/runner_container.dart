import 'package:flutter/material.dart';
import 'package:honomara/models/runner.dart';

class RunnerContainer extends StatelessWidget{
  const RunnerContainer({
    super.key,
    required this.runner,
    required this.index,
  });

  final Runner runner;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: index % 2 != 0? Colors.pink.shade50: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              runner.name,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            runner.grade,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              runner.time,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}