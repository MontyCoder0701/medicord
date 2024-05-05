// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomRecord _$CustomRecordFromJson(Map<String, dynamic> json) => CustomRecord(
      pcd: (json['pcd'] as num?)?.toDouble() ?? 0.0,
      ptbd: (json['ptbd'] as num?)?.toDouble() ?? 0.0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      bp: (json['bp'] as num?)?.toDouble() ?? 0.0,
      temp: (json['temp'] as num?)?.toDouble() ?? 0.0,
      memo: json['memo'] as String? ?? '',
    )
      ..id = (json['id'] as num?)?.toInt()
      ..createdAt = DateTime.parse(json['createdAt'] as String);

Map<String, dynamic> _$CustomRecordToJson(CustomRecord instance) =>
    <String, dynamic>{
      'pcd': instance.pcd,
      'ptbd': instance.ptbd,
      'weight': instance.weight,
      'bp': instance.bp,
      'temp': instance.temp,
      'memo': instance.memo,
    };
