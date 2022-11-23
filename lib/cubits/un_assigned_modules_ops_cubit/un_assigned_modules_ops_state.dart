part of 'un_assigned_modules_ops_cubit.dart';

abstract class UnAssignedModulesOpsState extends Equatable {
  const UnAssignedModulesOpsState();

  @override
  List<Object?> get props => [];
}

class UnAssignedModulesOpsInitialState extends UnAssignedModulesOpsState {
  const UnAssignedModulesOpsInitialState();

  @override
  List<Object?> get props => [];
}

class GotNotChildModulesState extends UnAssignedModulesOpsState {
  final List<QueryDocumentSnapshot<Module>> modules;

  const GotNotChildModulesState(
    this.modules,
  );

  @override
  List<Object?> get props => [
        modules,
      ];
}
