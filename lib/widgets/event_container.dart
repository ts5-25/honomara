import 'package:flutter/material.dart';
import 'package:honomara/models/event.dart';
import 'package:honomara/widgets/runner_container.dart';
import 'package:honomara/pages/personal_page.dart';

class EventContainer extends StatefulWidget {
  const EventContainer({super.key, required this.event});

  final Event event;

  @override
  State<EventContainer> createState() => _EventContainerState();
}

class _EventContainerState extends State<EventContainer> {
  bool _showRunners = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _showRunners = !_showRunners;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              color: Colors.black12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 日付
                  Text(
                    widget.event.date,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  // 大会名
                  Text(
                    widget.event.name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          if (_showRunners)
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5, // 高さを画面の50%に制限
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.event.runners.length,
                itemBuilder: (context, index) {
                  final runner = widget.event.runners[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => PersonalPage(name: runner.name, grade: runner.grade)),
                        ),
                      );// RunnerContainerをタップした時の処理
                    },
                    child: RunnerContainer(runner: runner, index: index),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}