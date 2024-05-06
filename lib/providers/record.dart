import 'package:flutter/foundation.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';

class RecordProvider with ChangeNotifier {
  final _repository = RecordRepository();
  List<CustomRecord> _resources = [];

  List<CustomRecord> get resources => _resources;

  List<CustomRecord> get currentMonthRecords => _resources
      .where((e) => e.createdAt.month == DateTime.now().month)
      .toList();

  Future<void> getMany() async {
    final result = await _repository.getMany();
    result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _resources = result;
    notifyListeners();
  }

  Future<void> createOne(CustomRecord record) async {
    final result = await _repository.createOne(record);
    _resources.insert(0, result);
  }

  void updateOne(CustomRecord record) {
    _repository.updateOne(record);
  }
}
