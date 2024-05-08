class Utilities {
  // DateTimeをフォーマットして返す
  static String getFormattedDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
