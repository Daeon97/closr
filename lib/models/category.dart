import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../utils/utils.dart' as utils;

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable {
  final utils.Category category;

  const Category(
    this.category,
  );

  @override
  List<Object?> get props => [
        category,
      ];

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
