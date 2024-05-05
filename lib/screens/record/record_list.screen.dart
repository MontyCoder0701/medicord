import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/helpers.dart';
import '../../providers/providers.dart';
import 'record_create.screen.dart';
import 'record_detail.screen.dart';

class RecordListScreen extends StatefulWidget {
  const RecordListScreen({super.key});

  @override
  State<RecordListScreen> createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<RecordListScreen> {
  late final _recordProvider = context.read<RecordProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: _recordProvider.resources.length,
        itemBuilder: (BuildContext context, int index) {
          final record = _recordProvider.resources[index];
          return ListTile(
            title: Text(formatDate(record.createdAt)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PCD: ${record.pcd}'),
                Text('PTBD: ${record.ptbd}'),
                Text('몸무게: ${record.weight}'),
                Text('혈압: ${record.bp}'),
                Text('체온: ${record.temp}'),
              ],
            ),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecordDetailScreen(record: record),
                ),
              );
              setState(() {});
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RecordCreateScreen(),
            ),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
