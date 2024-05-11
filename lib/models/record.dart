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

  bool get isBpAbnormal => isBpMaxAbnormal || isBpMinAbnormal;

  bool get isBpMinAbnormal => bpMin >= 100;

  bool get isBpMaxAbnormal => bpMax >= 150;

  bool get isTempAbnormal => temp >= 37.5;

  bool get isPcdAbnormal => pcd < 20;

  bool get isPtbdAbnormal => ptbd < 20;

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
