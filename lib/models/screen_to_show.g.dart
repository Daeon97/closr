// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_to_show.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScreenToShow _$ScreenToShowFromJson(Map<String, dynamic> json) => ScreenToShow(
      $enumDecode(_$ScreenToShowEnumMap, json['screenToShow']),
    );

Map<String, dynamic> _$ScreenToShowToJson(ScreenToShow instance) =>
    <String, dynamic>{
      'screenToShow': _$ScreenToShowEnumMap[instance.screenToShow]!,
    };

const _$ScreenToShowEnumMap = {
  utils.ScreenToShow.selectCategory: 'selectCategory',
  utils.ScreenToShow.signIn: 'signIn',
  utils.ScreenToShow.signUp: 'signUp',
};
