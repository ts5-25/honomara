import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:honomara/utils/time_utils.dart';
import 'package:honomara/widgets/runner_input.dart';

Future<void> addEvent({
  required String name,
  required String date,
  required List<RunnerInput> runners,
}) async {
  if (name.isNotEmpty && date.isNotEmpty) {
    List<Map<String, dynamic>> runnersData = [];
    for (var runner in runners) {
      String runnerName = runner.nameController.text;
      String runnerTime = runner.timeController.text;
      String runnerGrade = runner.gradeController.text;
      if (runnerName.isNotEmpty &&
          runnerTime.isNotEmpty &&
          runnerGrade.isNotEmpty) {
        runnersData.add({
          'name': runnerName,
          'time': runnerTime,
          'grade': runnerGrade,
        });

        // runnersコレクションのデータを更新する処理
        // DNFの場合はベストタイムを更新しない
        if (!isDnf(runnerTime)) {
          DocumentReference runnerRef =
              FirebaseFirestore.instance.collection('runners').doc(runnerName);

          DocumentSnapshot runnerDoc = await runnerRef.get();

          if (runnerDoc.exists) {
            String existingTime = runnerDoc['time'];
            if (existingTime.isEmpty ||
                isNewTimeFaster(existingTime, runnerTime)) {
              runnerRef.update({
                'time': runnerTime,
                'event': name,
                'date': date,
              });
            }
          } else {
            await runnerRef.set({
              'name': runnerName,
              'grade': runnerGrade,
              'time': runnerTime,
              'event': name,
              'date': date,
            });
          }
        } else {
          // DNFでもrunnersコレクションにドキュメントがなければ空タイムで作成
          DocumentReference runnerRef =
              FirebaseFirestore.instance.collection('runners').doc(runnerName);
          DocumentSnapshot runnerDoc = await runnerRef.get();
          if (!runnerDoc.exists) {
            await runnerRef.set({
              'name': runnerName,
              'grade': runnerGrade,
              'time': '',
              'event': '',
              'date': '',
            });
          }
        }
      }
    }

    // イベントのデータを更新する処理
    QuerySnapshot eventQuery = await FirebaseFirestore.instance
        .collection('events')
        .where('name', isEqualTo: name)
        .where('date', isEqualTo: date)
        .get();

    if (eventQuery.docs.isNotEmpty) {
      DocumentReference eventRef = eventQuery.docs.first.reference;
      DocumentSnapshot eventDoc = await eventRef.get();
      List<dynamic> existingRunners = eventDoc['runners'];

      for (var runnerData in runnersData) {
        bool runnerExists = false;
        for (var existingRunner in existingRunners) {
          if (existingRunner['name'] == runnerData['name']) {
            existingRunner['time'] = runnerData['time'];
            runnerExists = true;
            break;
          }
        }
        if (!runnerExists) {
          existingRunners.add(runnerData);
        }
      }

      // タイムが早い順にソート
      existingRunners.sort((a, b) {
        int aTime = parseTimeString(a['time']);
        int bTime = parseTimeString(b['time']);
        return aTime.compareTo(bTime);
      });

      await eventRef.update({'runners': existingRunners});
    } else {
      // タイムが早い順にソート
      runnersData.sort((a, b) {
        int aTime = parseTimeString(a['time']);
        int bTime = parseTimeString(b['time']);
        return aTime.compareTo(bTime);
      });
      DocumentReference newEventRef =
          FirebaseFirestore.instance.collection('events').doc();
      await newEventRef.set({
        'name': name,
        'date': date,
        'runners': runnersData,
      });
    }
  } else {
    throw Exception('すべてのフィールドを入力してください');
  }
}

bool isNewTimeFaster(String existingTime, String newTime) {
  int existingSeconds = parseTimeString(existingTime);
  int newSeconds = parseTimeString(newTime);

  return newSeconds < existingSeconds;
}
