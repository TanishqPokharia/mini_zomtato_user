String formatDate(DateTime date) {
  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final int day = date.day;
  final String month = months[date.month - 1];

  int hour = date.hour;
  final String amPm = hour >= 12 ? 'PM' : 'AM';

  // Convert to 12-hour format
  if (hour > 12) {
    hour -= 12;
  } else if (hour == 0) {
    hour = 12;
  }

  // Ensure minutes are padded with leading zero if needed
  final String minute = date.minute.toString().padLeft(2, '0');

  return '$day $month, $hour:$minute $amPm';
}
