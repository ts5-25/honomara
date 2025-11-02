import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:honomara/services/event_service.dart';
import 'package:honomara/widgets/runner_input.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  List<RunnerInput> _runners = [];

  @override
  void initState() {
    super.initState();
    _runners = [
      RunnerInput(
        onDelete: () => _removeRunnerInput(0),
        nameController: TextEditingController(),
        timeController: TextEditingController(),
        gradeController: TextEditingController(),
      )
    ];
  }

  void _handleAddEvent() async {
    String name = _nameController.text;
    String date = _dateController.text;

    try {
      await addEvent(name: name, date: date, runners: _runners);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('データの登録が完了しました')),
      );
      _nameController.clear();
      _dateController.clear();
      setState(() {
        _runners = [
          RunnerInput(
            onDelete: () => _removeRunnerInput(0),
            nameController: TextEditingController(),
            timeController: TextEditingController(),
            gradeController: TextEditingController(),
          )
        ];
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('データの登録に失敗しました: $error')),
      );
    }
  }

  void _addRunnerInput() {
    setState(() {
      int index = _runners.length;
      _runners.add(
        RunnerInput(
          onDelete: () => _removeRunnerInput(index),
          nameController: TextEditingController(),
          timeController: TextEditingController(),
          gradeController: TextEditingController(),
        ),
      );
    });
  }

  void _removeRunnerInput(int index) {
    if (index >= 0 && index < _runners.length) {
      setState(() {
        _runners.removeAt(index);
        // インデックスを更新
        for (int i = 0; i < _runners.length; i++) {
          _runners[i] = RunnerInput(
            key: UniqueKey(), // 各ウィジェットに一意のキーを設定
            onDelete: () => _removeRunnerInput(i),
            nameController: _runners[i].nameController,
            timeController: _runners[i].timeController,
            gradeController: _runners[i].gradeController,
          );
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.year}/${picked.month}/${picked.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('データの登録'),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('大会名:'),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('日付:'),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _dateController,
                    decoration: const InputDecoration(),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _runners.length + 1, // アイテム数を1つ増やす
                itemBuilder: (context, index) {
                  if (index == _runners.length) {
                    // 最後のアイテムとしてボタンを追加
                    return ElevatedButton(
                      onPressed: _addRunnerInput,
                      child: const Text('ランナーを追加'),
                    );
                  }
                  return _runners[index];
                },
              ),
            ),
            ElevatedButton(
              onPressed: _handleAddEvent,
              child: const Text('データベースに登録'),
            ),
          ],
        ),
      ),
    );
  }
}
