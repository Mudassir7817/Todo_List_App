class Helper {
  static String findTaskDay(DateTime dueDate) {
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(const Duration(days: 1));
    DateTime thismonth =
        DateTime(today.year, today.month + 1, 0).add(const Duration(days: 1));

    if (dueDate.year == today.year &&
        dueDate.month == today.month &&
        dueDate.day == today.day) {
      return 'Today';
    } else if (dueDate.year == tomorrow.year &&
        dueDate.month == tomorrow.month &&
        dueDate.day == tomorrow.day) {
      return 'tomorrow';
    } else if (dueDate.year == thismonth.year &&
        dueDate.month == thismonth.month &&
        dueDate.day == thismonth.day) {
      return "this month''s' task";
    }
    return 'Future Task';
  }
}
