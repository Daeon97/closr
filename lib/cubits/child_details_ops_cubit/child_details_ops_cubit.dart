import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../repos/repos.dart';
import '../../models/models.dart';

part 'child_details_ops_state.dart';

class ChildDetailsOpsCubit extends Cubit<ChildDetailsOpsState> {
  StreamSubscription<DocumentSnapshot<Child>>? _childDetailsStreamSubscription;
  final DatabaseRepo _databaseRepo;

  ChildDetailsOpsCubit(
    this._databaseRepo,
  ) : super(
          const ChildDetailsOpsInitialState(),
        );

  void listenChildDetailsChanges(
    String id,
  ) async {
    if (_childDetailsStreamSubscription != null) {
      await _childDetailsStreamSubscription!.cancel();
      _childDetailsStreamSubscription = null;
    }
    _childDetailsStreamSubscription = _databaseRepo.childDetails(id).listen(
      (documentSnapshot) {
        _childDetails(
          documentSnapshot,
        );
      },
    );
  }

  void _childDetails(
    DocumentSnapshot<Child> child,
  ) =>
      emit(
        GotChildDetailsState(
          child,
        ),
      );

  void stopListeningChildDetailsChanges() async {
    if (_childDetailsStreamSubscription != null) {
      await _childDetailsStreamSubscription!.cancel();
      _childDetailsStreamSubscription = null;
    }
  }
}
