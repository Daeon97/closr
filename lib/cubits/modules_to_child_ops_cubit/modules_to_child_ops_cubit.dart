import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../repos/repos.dart';
import '../../models/models.dart';

part 'modules_to_child_ops_state.dart';

class ModulesToChildOpsCubit extends Cubit<ModulesToChildOpsState> {
  StreamSubscription<QuerySnapshot<Module>>? _childModulesStreamSubscription;
  final DatabaseRepo _databaseRepo;

  ModulesToChildOpsCubit(
    this._databaseRepo,
  ) : super(
          const ModulesToChildOpsInitialState(),
        );

  void addModulesToChild({
    required String childId,
    required List<String> moduleIds,
  }) =>
      _databaseRepo.addModulesToChild(
        childId: childId,
        moduleIds: moduleIds,
      );

  void getChildModules(
    String id,
  ) async {
    final modules = await _databaseRepo.childModulesFuture(
      id,
    );
    emit(
      GotChildModulesState(
        modules,
      ),
    );
  }

  void listenChildModulesChanges(
    String id,
  ) async {
    if (_childModulesStreamSubscription != null) {
      await _childModulesStreamSubscription!.cancel();
      _childModulesStreamSubscription = null;
    }
    _childModulesStreamSubscription =
        _databaseRepo.childModulesStream(id).listen(
      (querySnapshot) {
        final modules = <QueryDocumentSnapshot<Module>>[];
        for (final queryDocumentSnapshot in querySnapshot.docs) {
          modules.add(queryDocumentSnapshot);
        }
        _childModules(
          modules,
        );
      },
    );
  }

  void _childModules(
    List<QueryDocumentSnapshot<Module>> modules,
  ) =>
      emit(
        GotChildModulesState(
          modules,
        ),
      );

  void stopListeningChildModulesChanges() async {
    if (_childModulesStreamSubscription != null) {
      await _childModulesStreamSubscription!.cancel();
      _childModulesStreamSubscription = null;
    }
  }
}
