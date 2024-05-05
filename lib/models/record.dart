import 'package:json_annotation/json_annotation.dart';

import 'base.dart';

part 'record.g.dart';

@JsonSerializable()
class Record extends BaseModel {
  @JsonKey()
  double pcd;

  @JsonKey()
  double ptbd;

  @JsonKey()
  double weight;

  @JsonKey()
  double bp;

  @JsonKey()
  double temp;

  @JsonKey()
  String memo;

  Record({
    this.pcd = 0.0,
    this.ptbd = 0.0,
    this.weight = 0.0,
    this.bp = 0.0,
    this.temp = 0.0,
    this.memo = '',
  });

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  Map<String, dynamic> toJson() => _$RecordToJson(this);
}
