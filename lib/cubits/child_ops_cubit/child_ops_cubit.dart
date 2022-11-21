import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../repos/repos.dart';
import '../../models/models.dart';

part 'child_ops_state.dart';

class ChildOpsCubit extends Cubit<ChildOpsState> {
  StreamSubscription<QuerySnapshot<Child>>? _childrenStreamSubscription;
  final DatabaseRepo _databaseRepo;

  ChildOpsCubit(
    this._databaseRepo,
  ) : super(
          const ChildOpsInitialState(),
        );

  void addChild({
    required String name,
    required int age,
    required String gender,
    required String mClass,
  }) =>
      _databaseRepo.addChild(
        name: name,
        age: age,
        gender: gender,
        mClass: mClass,
      );

  void listenChildrenChanges() async {
    if (_childrenStreamSubscription != null) {
      await _childrenStreamSubscription!.cancel();
      _childrenStreamSubscription = null;
    }
    _childrenStreamSubscription = _databaseRepo.children.listen(
      (querySnapshot) {
        final children = <QueryDocumentSnapshot<Child>>[];
        for (final queryDocumentSnapshot in querySnapshot.docs) {
          children.add(
            queryDocumentSnapshot,
          );
        }
        _children(children);
      },
    );
  }

  void _children(
    List<QueryDocumentSnapshot<Child>> children,
  ) =>
      emit(
        GotChildrenState(
          children,
        ),
      );

  void stopListeningChildrenChanges() async {
    if (_childrenStreamSubscription != null) {
      await _childrenStreamSubscription!.cancel();
      _childrenStreamSubscription = null;
    }
  }
}
