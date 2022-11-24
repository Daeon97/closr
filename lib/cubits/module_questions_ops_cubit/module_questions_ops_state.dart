part of 'module_questions_ops_cubit.dart';

abstract class ModuleQuestionsOpsState extends Equatable {
  const ModuleQuestionsOpsState();

  @override
  List<Object?> get props => [];
}

class ModuleQuestionsOpsInitialState extends ModuleQuestionsOpsState {
  const ModuleQuestionsOpsInitialState();

  @override
  List<Object?> get props => [];
}

class GotModuleQuestionsState extends ModuleQuestionsOpsState {
  final List<QueryDocumentSnapshot<Question>> questions;

  const GotModuleQuestionsState(
    this.questions,
  );

  @override
  List<Object?> get props => [
        questions,
      ];
}
