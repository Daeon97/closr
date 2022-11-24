import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'module_progress.g.dart';

@JsonSerializable()
class ModuleProgress extends Equatable {
  final double value;
  final int number;
  final int color;

  const ModuleProgress({
    required this.value,
    required this.number,
    required this.color,
  });

  @override
  List<Object?> get props => [];

  factory ModuleProgress.fromJson(Map<String, dynamic> json) =>
      _$ModuleProgressFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleProgressToJson(this);
}
