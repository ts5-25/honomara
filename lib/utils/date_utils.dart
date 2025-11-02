DateTime parseDateString(String dateString) {
  List<String> parts = dateString.split('/');
  if (parts.length != 3) {
    return DateTime(0); // 不正な日付文字列の場合は初期値を返す
  }
  int year = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int day = int.parse(parts[2]);
  return DateTime(year, month, day);
}
