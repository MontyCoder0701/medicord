import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../providers/providers.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({super.key});

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  late final _recordProvider = context.watch<RecordProvider>();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final records = _recordProvider.getRecordsByMonth(_focusedDay.month);

    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 14),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
          ),
          ListTile(
            title: Text('${_focusedDay.month}월 비정상 수치 횟수'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PCD : ${records.where((e) => e.isPcdAbnormal).length}회',
                ),
                Text(
                  'PTBD : ${records.where((e) => e.isPtbdAbnormal).length}회',
                ),
                Text(
                  '혈압 : ${records.where((e) => e.isBpAbnormal).length}회',
                ),
                Text(
                  '체온 : ${records.where((e) => e.isTempAbnormal).length}회',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
