import 'package:intl/intl.dart' as intl;

String getDetailDate(DateTime dateTime) {
  DateTime now = DateTime.now();
  DateTime flag = DateTime(now.year - 1);

  final Duration difference = now.difference(dateTime);
  if (difference.inSeconds <= 60) {
    return '방금 전';
  } else if (difference.inMinutes <= 60) {
    return '${difference.inMinutes}분 전';
  } else if (difference.inHours <= 24) {
    return '${difference.inHours}시간 전';
  } else if (difference.inHours >= 24 &&
      (difference.inDays ~/ 365).ceil() < 1) {
    return '${intl.DateFormat('MM.dd').format(dateTime)}';
  } else {
    return '${(difference.inDays ~/ 365).ceil()}년 전';
  }
}

String capitalize(String letter) {
  if (letter.trim().isEmpty) return '';

  return '${letter[0].toUpperCase()}${letter.substring(1)}';
}
