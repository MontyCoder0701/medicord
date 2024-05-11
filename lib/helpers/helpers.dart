import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime datetime) {
  final dateFormat = DateFormat('yyyy-MM-dd');
  return dateFormat.format(datetime);
}

IconData transformIntToIcon(int int) {
  switch (int) {
    case 1:
      return Icons.arrow_upward;
    case -1:
      return Icons.arrow_downward;
    default:
      return Icons.horizontal_rule;
  }
}
