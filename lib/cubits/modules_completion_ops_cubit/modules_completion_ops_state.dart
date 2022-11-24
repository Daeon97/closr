part of 'modules_completion_ops_cubit.dart';

abstract class ModulesCompletionOpsState extends Equatable {
  const ModulesCompletionOpsState();

  @override
  List<Object?> get props => [];
}

class ModulesCompletionOpsInitialState extends ModulesCompletionOpsState {
  const ModulesCompletionOpsInitialState();

  @override
  List<Object?> get props => [];
}

class GotModulesCompletionState extends ModulesCompletionOpsState {
  final ModuleProgress moduleProgress;

  const GotModulesCompletionState(
    this.moduleProgress,
  );

  @override
  List<Object?> get props => [
        moduleProgress,
      ];
}
