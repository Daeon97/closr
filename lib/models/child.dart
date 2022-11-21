import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../utils/utils.dart';

part 'child.g.dart';

@JsonSerializable()
class Child extends Equatable {
  final String name;
  final int age;

  @JsonKey(name: classField)
  final String mClass;

  final String gender;

  const Child({
    required this.name,
    required this.age,
    required this.mClass,
    required this.gender,
  });

  @override
  List<Object?> get props => [
        name,
        age,
        mClass,
        gender,
      ];

  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);

  Map<String, dynamic> toJson() => _$ChildToJson(this);
}
