part of 'modules_to_child_ops_cubit.dart';

abstract class ModulesToChildOpsState extends Equatable {
  const ModulesToChildOpsState();

  @override
  List<Object?> get props => [];
}

class ModulesToChildOpsInitialState extends ModulesToChildOpsState {
  const ModulesToChildOpsInitialState();

  @override
  List<Object?> get props => [];
}

class GotChildModulesState extends ModulesToChildOpsState {
  final List<QueryDocumentSnapshot<Module>> modules;

  const GotChildModulesState(
    this.modules,
  );

  @override
  List<Object?> get props => [
        modules,
      ];
}
