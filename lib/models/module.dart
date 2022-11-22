import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'module.g.dart';

@JsonSerializable()
class Module extends Equatable {
  final String name;
  final String description;

  const Module({
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [
        name,
        description,
      ];

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);
}
