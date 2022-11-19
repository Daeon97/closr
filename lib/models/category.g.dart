// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      $enumDecode(_$CategoryEnumMap, json['category']),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'category': _$CategoryEnumMap[instance.category]!,
    };

const _$CategoryEnumMap = {
  utils.Category.child: 'child',
  utils.Category.parent: 'parent',
};
