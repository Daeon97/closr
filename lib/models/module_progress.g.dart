// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleProgress _$ModuleProgressFromJson(Map<String, dynamic> json) =>
    ModuleProgress(
      value: (json['value'] as num).toDouble(),
      number: json['number'] as int,
      color: json['color'] as int,
    );

Map<String, dynamic> _$ModuleProgressToJson(ModuleProgress instance) =>
    <String, dynamic>{
      'value': instance.value,
      'number': instance.number,
      'color': instance.color,
    };
