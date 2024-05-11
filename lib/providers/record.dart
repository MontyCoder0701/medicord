import 'package:flutter/foundation.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';

class RecordProvider with ChangeNotifier {
  final _repository = RecordRepository();
  List<CustomRecord> _resources = [];

  List<CustomRecord> get resources {
    _resources.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return _resources;
  }

  List<int> get createdAtMonths {
    return _resources.map((e) => e.createdAt.month).toSet().toList();
  }

  List<CustomRecord> getRecordsByMonth(int month) {
    return _resources.where((e) => e.createdAt.month == month).toList();
  }

  Future<void> getMany() async {
    final result = await _repository.getMany();
    _resources = result;
    notifyListeners();
  }

  Future<void> createOne(CustomRecord record) async {
    final result = await _repository.createOne(record);
    _resources.add(result);
  }

  Future<void> updateOne(CustomRecord record) async {
    await _repository.updateOne(record);
  }

  Future<void> deleteOne(CustomRecord record) async {
    await _repository.deleteOne(record.id!);
    _resources.remove(record);
  }

  int? comparePcd(CustomRecord record) {
    final currentIndex = resources.indexOf(record);
    if (currentIndex == resources.length - 1) {
      return null;
    }

    final previousRecord = resources[currentIndex + 1];
    if (record.pcd > previousRecord.pcd) {
      return 1;
    } else if (record.pcd < previousRecord.pcd) {
      return -1;
    } else {
      return 0;
    }
  }

  int? comparePtbd(CustomRecord record) {
    final currentIndex = resources.indexOf(record);
    if (currentIndex == resources.length - 1) {
      return null;
    }

    final previousRecord = resources[currentIndex + 1];
    if (record.ptbd > previousRecord.ptbd) {
      return 1;
    } else if (record.ptbd < previousRecord.ptbd) {
      return -1;
    } else {
      return 0;
    }
  }
}
