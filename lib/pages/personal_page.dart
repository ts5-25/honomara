import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:honomara/models/person.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:honomara/widgets/record_container.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({
    super.key,
    required this.name,
    required this.grade,
    this.pb = "",
  }); 

  final String name;
  final String grade;
  final String pb;

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  Person? person;

  Future<void> getData() async {
    final jsonData = await rootBundle.loadString('json/data.json');
    final Map<String, dynamic> decodedData = jsonDecode(jsonData);
    final List<dynamic> eventData = decodedData['event'];
    person = Person.fromJson(widget.name, widget.grade, widget.pb, eventData);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('フルマラソンの記録'),
      ),
      body: person != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    color: Colors.blue[100],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ), // 余白を追加
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            person!.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          person!.grade,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                        Expanded(child:
                        Text(
                          person!.pb!,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                        ),
                      ],
                    ),
                  
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: person!.records.length,
                    itemBuilder: (context, index) {
                      final record = person!.records[index];
                      return RecordContainer(record: record, index: index, isPB: record.time == person!.pb!);
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

