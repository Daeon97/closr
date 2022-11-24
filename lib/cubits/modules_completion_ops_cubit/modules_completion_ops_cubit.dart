import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/models.dart';
import '../../repos/repos.dart';
import '../../utils/utils.dart';

part 'modules_completion_ops_state.dart';

class ModulesCompletionOpsCubit extends Cubit<ModulesCompletionOpsState> {
  StreamSubscription<QuerySnapshot<Question>>?
      _childModuleQuestionsWithAnswerStreamSubscription;
  final DatabaseRepo _databaseRepo;

  ModulesCompletionOpsCubit(
    this._databaseRepo,
  ) : super(
          const ModulesCompletionOpsInitialState(),
        );

  void listenChildModuleQuestionsAnswerChanges({
    required String childId,
    required String moduleId,
  }) async {
    if (_childModuleQuestionsWithAnswerStreamSubscription != null) {
      await _childModuleQuestionsWithAnswerStreamSubscription!.cancel();
      _childModuleQuestionsWithAnswerStreamSubscription = null;
    }
    _childModuleQuestionsWithAnswerStreamSubscription = _databaseRepo
        .childModuleQuestionsWithAnswerStream(
      childId: childId,
      moduleId: moduleId,
    )
        .listen(
      (querySnapshot) async {
        final childModuleQuestions =
            await _databaseRepo.childModuleQuestionsFuture(
          childId: childId,
          moduleId: moduleId,
        );

        double value = nil;
        int number = nil.toInt();

        if (childModuleQuestions.isNotEmpty) {
          int totalQuestions = childModuleQuestions.length;
          int questionsWithAnswer = nil.toInt();

          for (final _ in querySnapshot.docs) {
            questionsWithAnswer += veryTinyPadding.toInt();
          }

          value = double.parse((questionsWithAnswer / totalQuestions)
              .toStringAsFixed(tinyPadding.toInt()));
          number = (value * oneHundredDotNil).toInt();
        }

        final moduleProgress = ModuleProgress(
          value: value,
          number: number,
          color: _computeColor(),
        );
        _childModuleQuestionsWithAnswer(
          moduleProgress,
        );
      },
    );
  }

  // modify this function later
  int _computeColor() {
    return 1;
  }

  void _childModuleQuestionsWithAnswer(
    ModuleProgress moduleProgress,
  ) {
    emit(
      GotModulesCompletionState(
        moduleProgress,
      ),
    );
  }

  void stopListeningChildModuleQuestionsAnswerChanges() async {
    if (_childModuleQuestionsWithAnswerStreamSubscription != null) {
      await _childModuleQuestionsWithAnswerStreamSubscription!.cancel();
      _childModuleQuestionsWithAnswerStreamSubscription = null;
    }
  }
}
