const int dnfSortValue = 999999;

bool isDnf(String timeString) {
  final parts = timeString.split(':');
  if (parts.length != 3) {
    return false;
  }
  final hours = int.tryParse(parts[0]);
  final minutes = int.tryParse(parts[1]);
  final seconds = int.tryParse(parts[2]);
  return hours == 0 && minutes == 0 && seconds == 0;
}

int parseTimeString(String timeString) {
  if (isDnf(timeString)) {
    return dnfSortValue;
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