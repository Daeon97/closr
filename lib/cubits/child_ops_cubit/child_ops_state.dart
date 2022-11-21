part of 'child_ops_cubit.dart';

abstract class ChildOpsState extends Equatable {
  const ChildOpsState();

  @override
  List<Object?> get props => [];
}

class ChildOpsInitialState extends ChildOpsState {
  const ChildOpsInitialState();

  @override
  List<Object?> get props => [];
}

class GotChildrenState extends ChildOpsState {
  final List<QueryDocumentSnapshot<Child>> children;

  const GotChildrenState(
    this.children,
  );

  @override
  List<Object?> get props => [
        children,
      ];
}
