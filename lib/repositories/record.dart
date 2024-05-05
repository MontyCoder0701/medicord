import '../models/models.dart';
import 'local.dart';

class RecordRepository extends LocalRepository<CustomRecord> {
  @override
  get key => 'temp';

  @override
  toJson(item) => item.toJson();

  @override
  fromJson(Map<String, dynamic> json) => CustomRecord.fromJson(json);
}
