// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Record _$RecordFromJson(Map<String, dynamic> json) => Record(
      pcd: (json['pcd'] as num?)?.toDouble() ?? 0.0,
      ptbd: (json['ptbd'] as num?)?.toDouble() ?? 0.0,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      bp: (json['bp'] as num?)?.toDouble() ?? 0.0,
      temp: (json['temp'] as num?)?.toDouble() ?? 0.0,
      memo: json['memo'] as String? ?? '',
    )
      ..id = (json['id'] as num?)?.toInt()
      ..createdAt = json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String);

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'pcd': instance.pcd,
      'ptbd': instance.ptbd,
      'weight': instance.weight,
      'bp': instance.bp,
      'temp': instance.temp,
      'memo': instance.memo,
    };
