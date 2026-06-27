const String dnfTime = '0:00:00';

bool isDnf(String timeString) {
  return timeString == dnfTime;
}

int parseTimeString(String timeString) {
  if (isDnf(timeString)) {
    return 999999; // DNFはソートで最後に来るようにする
  }
  List<String> parts = timeString.split(':');
  if (parts.length != 3) {
    return 0; // 不正な時間文字列の場合は0を返す
  }
  int hours = int.parse(parts[0]);
  int minutes = int.parse(parts[1]);
  int seconds = int.parse(parts[2]);
  return hours * 3600 + minutes * 60 + seconds;
}