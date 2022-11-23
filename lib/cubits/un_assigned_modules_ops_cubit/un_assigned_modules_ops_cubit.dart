import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../repos/repos.dart';
import '../../models/models.dart';

part 'un_assigned_modules_ops_state.dart';

class UnAssignedModulesOpsCubit extends Cubit<UnAssignedModulesOpsState> {
  final DatabaseRepo _databaseRepo;

  UnAssignedModulesOpsCubit(
    this._databaseRepo,
  ) : super(
          const UnAssignedModulesOpsInitialState(),
        );

  void getNotChildModules(String id) async {
    final modules = await _databaseRepo.notChildModulesFuture(
      id,
    );
    emit(
      GotNotChildModulesState(
        modules,
      ),
    );
  }
}
