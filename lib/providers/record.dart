import 'package:flutter/foundation.dart';

import '../models/models.dart';

class RecordProvider with ChangeNotifier {
  final List<CustomRecord> _resources = [];

  List<CustomRecord> get resources => _resources;

  List<CustomRecord> get currentMonthRecords => _resources
      .where((e) => e.createdAt.month == DateTime.now().month)
      .toList();

  Future<void> createOne(CustomRecord record) async {
    _resources.add(record);
  }

  Future<void> updateOne(CustomRecord record) async {}
}
