import 'package:json_annotation/json_annotation.dart';

import 'base.dart';

part 'record.g.dart';

@JsonSerializable()
class CustomRecord extends BaseModel {
  @JsonKey()
  double pcd;

  @JsonKey()
  double ptbd;

  @JsonKey()
  double weight;

  @JsonKey()
  double bpMin;

  @JsonKey()
  double bpMax;

  @JsonKey()
  double temp;

  @JsonKey()
  String memo;

  CustomRecord({
    this.pcd = 0.0,
    this.ptbd = 0.0,
    this.weight = 0.0,
    this.bpMin = 0.0,
    this.bpMax = 0.0,
    this.temp = 0.0,
    this.memo = '',
  });

  factory CustomRecord.fromJson(Map<String, dynamic> json) =>
      _$CustomRecordFromJson(json);

  Map<String, dynamic> toJson() => _$CustomRecordToJson(this);
}
