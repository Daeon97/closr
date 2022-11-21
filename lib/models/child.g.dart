// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Child _$ChildFromJson(Map<String, dynamic> json) => Child(
      name: json['name'] as String,
      age: json['age'] as int,
      mClass: json['class'] as String,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$ChildToJson(Child instance) => <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'class': instance.mClass,
      'gender': instance.gender,
    };
