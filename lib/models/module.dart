import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'module.g.dart';

@JsonSerializable()
class Module extends Equatable {
  final String name;
  final String description;

  @JsonKey(includeIfNull: false)
  final Timestamp? timestamp;

  const Module({
    required this.name,
    required this.description,
    this.timestamp,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        timestamp,
      ];

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);
}
