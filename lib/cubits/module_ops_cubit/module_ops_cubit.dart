import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../repos/repos.dart';
import '../../models/models.dart';

part 'module_ops_state.dart';

class ModuleOpsCubit extends Cubit<ModuleOpsState> {
  final DatabaseRepo _databaseRepo;

  ModuleOpsCubit(
    this._databaseRepo,
  ) : super(
          const ModuleOpsInitialState(),
        );

  void getModules() async {
    final modules = <QueryDocumentSnapshot<Module>>[];
    final querySnapshot = await _databaseRepo.modules;

    for (final queryDocumentSnapshot in querySnapshot.docs) {
      modules.add(
        queryDocumentSnapshot,
      );
    }
    _modules(modules);
  }

  void _modules(
    List<QueryDocumentSnapshot<Module>> modules,
  ) =>
      emit(
        GotModulesState(
          modules,
        ),
      );
}
