import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honomara/components/time_formatter.dart';

class RunnerInput extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController timeController;
  final TextEditingController gradeController;
  final VoidCallback onDelete;

  const RunnerInput({
    super.key,
    required this.onDelete,
    required this.nameController,
    required this.timeController,
    required this.gradeController,
  });

  @override
  State<RunnerInput> createState() => _RunnerInputState();
}

class _RunnerInputState extends State<RunnerInput> {
  final List<String> _grades = ['27期', '28期', '29期', '30期', '31期', '32期', '33期'];
  List<String> _names = [];

  @override
  void initState() {
    super.initState();
    _fetchNames(widget.gradeController.text);
  }

  void _fetchNames(String grade) async {
    if (grade.isNotEmpty) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('runners')
          .where('grade', isEqualTo: grade)
          .get();
      setState(() {
        _names =
            querySnapshot.docs.map((doc) => doc['name'] as String).toList();
      });
    }
  }

  void _onGradeChanged(String? grade) async {
    if (grade != null) {
      widget.gradeController.text = grade;
      widget.nameController.clear();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('runners')
          .where('grade', isEqualTo: grade)
          .get();
      setState(() {
        _names =
            querySnapshot.docs.map((doc) => doc['name'] as String).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: DropdownButtonFormField<String>(
                value: _grades.contains(widget.gradeController.text)
                    ? widget.gradeController.text
                    : null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  labelText: '学年',
                ),
                items: _grades.map((String grade) {
                  return DropdownMenuItem<String>(
                    value: grade,
                    child: Text(
                      grade,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: _onGradeChanged,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: DropdownButtonFormField<String>(
                value: _names.contains(widget.nameController.text)
                    ? widget.nameController.text
                    : null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  labelText: '名前',
                ),
                items: [
                  ..._names.map((String name) {
                    return DropdownMenuItem<String>(
                      value: name,
                      child: Text(
                        name,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }),
                  const DropdownMenuItem<String>(
                    value: 'new',
                    child: Text(
                      '新規登録',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
                onChanged: (String? name) {
                  if (name != null) {
                    if (name == 'new') {
                      _showNewRunnerDialog();
                    } else {
                      setState(() {
                        widget.nameController.text = name;
                      });
                    }
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text('タイム:'),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: widget.timeController,
                decoration: const InputDecoration(),
                style: const TextStyle(color: Colors.black),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d{1,2}(:\d{0,2})?(:\d{0,2})?$')),
                  TimeInputFormatter(),
                ],
                keyboardType: TextInputType.text,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: widget.onDelete, // 削除ボタンのコールバックを呼び出す
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(thickness: 2), // ランナーごとの区切り
      ],
    );
  }

  void _showNewRunnerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController newNameController = TextEditingController();
        final TextEditingController newGradeController =
            TextEditingController(text: widget.gradeController.text);
        return AlertDialog(
          title: const Text('新規ランナー登録'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newGradeController,
                decoration: const InputDecoration(labelText: '学年'),
                style: const TextStyle(color: Colors.black),
              ),
              TextField(
                controller: newNameController,
                decoration: const InputDecoration(labelText: '名前'),
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () async {
                String newName = newNameController.text;
                String newGrade = newGradeController.text;
                if (newName.isNotEmpty && newGrade.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection('runners')
                      .doc(newName)
                      .set({
                    'name': newName,
                    'grade': newGrade,
                    'time': "",
                    'event': "",
                    'date': "",
                  });
                  setState(() {
                    widget.nameController.text = newName;
                    widget.gradeController.text = newGrade;
                    _names.add(newName);
                  });
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                }
              },
              child: const Text('登録'),
            ),
          ],
        );
      },
    );
  }
}
