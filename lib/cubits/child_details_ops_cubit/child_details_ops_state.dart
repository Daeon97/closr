part of 'child_details_ops_cubit.dart';

abstract class ChildDetailsOpsState extends Equatable {
  const ChildDetailsOpsState();

  @override
  List<Object?> get props => [];
}

class ChildDetailsOpsInitialState extends ChildDetailsOpsState {
  const ChildDetailsOpsInitialState();

  @override
  List<Object?> get props => [];
}

class GotChildDetailsState extends ChildDetailsOpsState {
  final DocumentSnapshot<Child> child;

  const GotChildDetailsState(
    this.child,
  );

  @override
  List<Object?> get props => [
        child,
      ];
}
