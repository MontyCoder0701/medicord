import 'package:flutter/foundation.dart';

import '../models/models.dart';

class RecordProvider with ChangeNotifier {
  final List<CustomRecord> _resources = [];

  List<CustomRecord> get resources => _resources;

  Future<void> createOne(CustomRecord record) async {
    _resources.add(record);
  }
}
