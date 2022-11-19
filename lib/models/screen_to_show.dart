import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../utils/utils.dart' as utils;

part 'screen_to_show.g.dart';

@JsonSerializable()
class ScreenToShow extends Equatable {
  final utils.ScreenToShow screenToShow;

  const ScreenToShow(
    this.screenToShow,
  );

  @override
  List<Object?> get props => [
        screenToShow,
      ];

  factory ScreenToShow.fromJson(Map<String, dynamic> json) =>
      _$ScreenToShowFromJson(json);

  Map<String, dynamic> toJson() => _$ScreenToShowToJson(this);
}
