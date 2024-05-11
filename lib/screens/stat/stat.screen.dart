import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../record/record.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({super.key});

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  late final _theme = Theme.of(context);
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
            calendarStyle: const CalendarStyle(
              markerSize: 7.0,
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            eventLoader: (day) => _recordProvider.events[day] ?? [],
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              final record = _recordProvider.getRecordByDateTime(selectedDay);
              if (record != null) {
                _handleRecordDetailDialogOpen(record);
              }

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

  Future<void> _handleRecordDetailDialogOpen(CustomRecord record) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(formatDate(record.createdAt)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'PCD: ${record.pcd}',
                style: TextStyle(
                  color: record.isPcdAbnormal ? _theme.colorScheme.error : null,
                ),
              ),
              Text(
                'PTBD: ${record.ptbd}',
                style: TextStyle(
                  color:
                      record.isPtbdAbnormal ? _theme.colorScheme.error : null,
                ),
              ),
              Text('몸무게: ${record.weight}'),
              Text(
                '혈압: ${record.bpMax} / ${record.bpMin}',
                style: TextStyle(
                  color: record.isBpAbnormal ? _theme.colorScheme.error : null,
                ),
              ),
              Text(
                '체온: ${record.temp}',
                style: TextStyle(
                  color:
                      record.isTempAbnormal ? _theme.colorScheme.error : null,
                ),
              ),
              if (record.memo.isNotEmpty) ...{
                Text(
                  '메모: ${record.memo}',
                  style: TextStyle(color: _theme.colorScheme.primary),
                ),
              },
            ],
          ),
          actions: [
            IconButton(
              onPressed: () async {
                Navigator.pop(context);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecordDetailScreen(record: record),
                  ),
                );
                setState(() {});
              },
              icon: const Icon(
                Icons.arrow_forward_outlined,
              ),
            ),
          ],
        );
      },
    );
  }
}
