import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question extends Equatable {
  final String question;
  final List<String> options;

  @JsonKey(includeIfNull: false)
  final int? answer;

  const Question({
    required this.question,
    required this.options,
    this.answer,
  });

  @override
  List<Object?> get props => [
        question,
        options,
        answer,
      ];

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
