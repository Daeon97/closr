import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/models.dart';
import '../../repos/repos.dart';

part 'module_questions_ops_state.dart';

class ModuleQuestionsOpsCubit extends Cubit<ModuleQuestionsOpsState> {
  StreamSubscription<QuerySnapshot<Question>>?
      _childModuleQuestionsStreamSubscription;
  final DatabaseRepo _databaseRepo;

  ModuleQuestionsOpsCubit(
    this._databaseRepo,
  ) : super(
          const ModuleQuestionsOpsInitialState(),
        );

  void answerQuestion({
    required String childId,
    required String moduleId,
    required String questionId,
    required int answer,
  }) =>
      _databaseRepo.answerQuestion(
        childId: childId,
        moduleId: moduleId,
        questionId: questionId,
        answer: answer,
      );

  void listenChildModuleQuestionsChanges({
    required String childId,
    required String moduleId,
  }) async {
    if (_childModuleQuestionsStreamSubscription != null) {
      await _childModuleQuestionsStreamSubscription!.cancel();
      _childModuleQuestionsStreamSubscription = null;
    }
    _childModuleQuestionsStreamSubscription = _databaseRepo
        .childModuleQuestionsStream(
      childId: childId,
      moduleId: moduleId,
    )
        .listen(
      (querySnapshot) {
        final questions = <QueryDocumentSnapshot<Question>>[];
        for (final queryDocumentSnapshot in querySnapshot.docs) {
          questions.add(queryDocumentSnapshot);
        }
        _moduleQuestions(
          questions,
        );
      },
    );
  }

  void _moduleQuestions(
    List<QueryDocumentSnapshot<Question>> questions,
  ) =>
      emit(
        GotModuleQuestionsState(
          questions,
        ),
      );

  void stopListeningModuleQuestionsChanges() async {
    if (_childModuleQuestionsStreamSubscription != null) {
      await _childModuleQuestionsStreamSubscription!.cancel();
      _childModuleQuestionsStreamSubscription = null;
    }
  }
}
