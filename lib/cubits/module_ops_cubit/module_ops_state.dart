part of 'module_ops_cubit.dart';

abstract class ModuleOpsState extends Equatable {
  const ModuleOpsState();

  @override
  List<Object?> get props => [];
}

class ModuleOpsInitialState extends ModuleOpsState {
  const ModuleOpsInitialState();

  @override
  List<Object?> get props => [];
}

class GotModulesState extends ModuleOpsState {
  final List<QueryDocumentSnapshot<Module>> modules;

  const GotModulesState(
    this.modules,
  );

  @override
  List<Object?> get props => [
        modules,
      ];
}
