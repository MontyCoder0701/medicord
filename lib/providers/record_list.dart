import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';

class RecordListProvider with ChangeNotifier {
  final _repository = RecordRepository();
  List<CustomRecord> _resources = [];

  List<CustomRecord> get resources {
    _resources.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return _resources;
  }

  Map<DateTime, List<CustomRecord>> get events {
    Map<DateTime, List<CustomRecord>> events = {};

    List<CustomRecord> eventRecords =
        _resources.where((record) => record.isAbnormal).toList();

    for (CustomRecord record in eventRecords) {
      DateTime dayKey = DateTime.utc(
        record.createdAt.year,
        record.createdAt.month,
        record.createdAt.day,
      );

      if (events.containsKey(dayKey)) {
        events[dayKey]!.add(record);
      } else {
        events[dayKey] = [record];
      }
    }

    return events;
  }

  List<CustomRecord> getRecordsByMonth(DateTime dateTime) {
    return _resources
        .where(
          (e) =>
              e.createdAt.year == dateTime.year &&
              e.createdAt.month == dateTime.month,
        )
        .toList();
  }

  CustomRecord? getRecordByDay(DateTime dateTime) {
    return _resources.firstWhereOrNull(
      (e) =>
          e.createdAt.year == dateTime.year &&
          e.createdAt.month == dateTime.month &&
          e.createdAt.day == dateTime.day,
    );
  }

  CustomRecord findOne({required int id}) {
    return _resources.firstWhere((e) => e.id == id);
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
