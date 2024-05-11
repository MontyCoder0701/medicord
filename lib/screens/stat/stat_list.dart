import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';

class StatListScreen extends StatefulWidget {
  const StatListScreen({super.key});

  @override
  State<StatListScreen> createState() => _StatListScreenState();
}

class _StatListScreenState extends State<StatListScreen> {
  late final _recordProvider = context.watch<RecordProvider>();
  late final _createdAtMonths = _recordProvider.createdAtMonths;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: _createdAtMonths.length,
        itemBuilder: (BuildContext context, int index) {
          final createdAtMonth = _createdAtMonths[index];
          final records = _recordProvider.getRecordsByMonth(createdAtMonth);

          return ListTile(
            title: Text('$createdAtMonth월 비정상 수치 횟수'),
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
          );
        },
      ),
    );
  }
}
