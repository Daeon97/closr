import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/models.dart';
import '../utils/utils.dart';

class DatabaseRepo {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  DatabaseRepo()
      : _auth = FirebaseAuth.instance,
        _firestore = FirebaseFirestore.instance;

  Future<void> addChild({
    required String name,
    required int age,
    required String gender,
    required String mClass,
  }) =>
      _firestore.collection(childrenCollectionName).doc().set({
        nameField: name,
        ageField: age,
        genderField: gender,
        classField: mClass,
        parentField: _auth.currentUser!.uid,
        timestampField: FieldValue.serverTimestamp(),
      });

  Stream<QuerySnapshot<Child>> get childrenStream => _firestore
      .collection(childrenCollectionName)
      .where(
        parentField,
        isEqualTo: _auth.currentUser!.uid,
      )
      .withConverter<Child>(
        fromFirestore: (documentSnapshot, _) => Child.fromJson(
          documentSnapshot.data()!,
        ),
        toFirestore: (child, _) => child.toJson(),
      )
      .snapshots();

  Stream<DocumentSnapshot<Child>> childDetailsStream(
    String id,
  ) =>
      _firestore
          .collection(childrenCollectionName)
          .doc(id)
          .withConverter<Child>(
            fromFirestore: (documentSnapshot, _) => Child.fromJson(
              documentSnapshot.data()!,
            ),
            toFirestore: (child, _) => child.toJson(),
          )
          .snapshots();

  Future<QuerySnapshot<Module>> get modulesFuture => _firestore
      .collection(modulesCollectionName)
      .withConverter(
        fromFirestore: (documentSnapshot, _) =>
            Module.fromJson(documentSnapshot.data()!),
        toFirestore: (module, _) => module.toJson(),
      )
      .get();

  Future<void> addModulesToChild({
    required String childId,
    required List<String> moduleIds,
  }) async {
    for (final moduleId in moduleIds) {
      final moduleDocumentSnapshot = await _firestore
          .collection(modulesCollectionName)
          .doc(moduleId)
          .get();
      final childModuleDocumentReference = _firestore
          .collection(childrenCollectionName)
          .doc(childId)
          .collection(modulesCollectionName)
          .doc(moduleDocumentSnapshot.id);
      final moduleQuestionsQuerySnapshot = await moduleDocumentSnapshot
          .reference
          .collection(questionsCollectionName)
          .get();
      if (moduleQuestionsQuerySnapshot.docs.isNotEmpty) {
        for (final moduleQuestionsQueryDocumentSnapshot
            in moduleQuestionsQuerySnapshot.docs) {
          await childModuleDocumentReference
              .collection(questionsCollectionName)
              .doc(moduleQuestionsQueryDocumentSnapshot.id)
              .set({
            optionsField:
                moduleQuestionsQueryDocumentSnapshot.data()[optionsField],
            questionField:
                moduleQuestionsQueryDocumentSnapshot.data()[questionField],
          });
        }
      }
      await childModuleDocumentReference.set({
        nameField: moduleDocumentSnapshot.data()![nameField],
        descriptionField: moduleDocumentSnapshot.data()![descriptionField],
      });
    }
  }

  Stream<QuerySnapshot<Question>> childModuleQuestionsStream({
    required String childId,
    required String moduleId,
  }) =>
      _firestore
          .collection(childrenCollectionName)
          .doc(childId)
          .collection(modulesCollectionName)
          .doc(moduleId)
          .collection(questionsCollectionName)
          .withConverter(
            fromFirestore: (documentSnapshot, _) =>
                Question.fromJson(documentSnapshot.data()!),
            toFirestore: (question, _) => question.toJson(),
          )
          .snapshots();

  Future<List<QueryDocumentSnapshot<Question>>> childModuleQuestionsFuture({
    required String childId,
    required String moduleId,
  }) =>
      _firestore
          .collection(childrenCollectionName)
          .doc(childId)
          .collection(modulesCollectionName)
          .doc(moduleId)
          .collection(questionsCollectionName)
          .withConverter(
            fromFirestore: (documentSnapshot, _) =>
                Question.fromJson(documentSnapshot.data()!),
            toFirestore: (question, _) => question.toJson(),
          )
          .get()
          .then(
        (querySnapshot) {
          final questions = <QueryDocumentSnapshot<Question>>[];
          if (querySnapshot.docs.isNotEmpty) {
            for (final queryDocumentSnapshot in querySnapshot.docs) {
              questions.add(queryDocumentSnapshot);
            }
          }
          return questions;
        },
      );

  Stream<QuerySnapshot<Module>> childModulesStream(
    String id,
  ) =>
      _firestore
          .collection(childrenCollectionName)
          .doc(id)
          .collection(modulesCollectionName)
          .withConverter(
            fromFirestore: (documentSnapshot, _) =>
                Module.fromJson(documentSnapshot.data()!),
            toFirestore: (module, _) => module.toJson(),
          )
          .snapshots();

  Future<List<QueryDocumentSnapshot<Module>>> notChildModulesFuture(
    String id,
  ) async {
    final modulesQuerySnapshot = await _firestore
        .collection(modulesCollectionName)
        .withConverter(
          fromFirestore: (documentSnapshot, _) =>
              Module.fromJson(documentSnapshot.data()!),
          toFirestore: (module, _) => module.toJson(),
        )
        .get();
    final childModulesQuerySnapshot = await _firestore
        .collection(childrenCollectionName)
        .doc(id)
        .collection(modulesCollectionName)
        .withConverter(
          fromFirestore: (documentSnapshot, _) =>
              Module.fromJson(documentSnapshot.data()!),
          toFirestore: (module, _) => module.toJson(),
        )
        .get();
    final modules = <QueryDocumentSnapshot<Module>>[];
    final childModulesDocIds = <String>[];

    if (childModulesQuerySnapshot.docs.isNotEmpty) {
      for (final childModulesQueryDocumentSnapshot
          in childModulesQuerySnapshot.docs) {
        childModulesDocIds.add(
          childModulesQueryDocumentSnapshot.id,
        );
      }
    }

    for (final moduleQueryDocumentSnapshot in modulesQuerySnapshot.docs) {
      if (childModulesDocIds.isNotEmpty) {
        if (!childModulesDocIds.contains(moduleQueryDocumentSnapshot.id)) {
          modules.add(moduleQueryDocumentSnapshot);
        }
      } else {
        modules.add(moduleQueryDocumentSnapshot);
      }
    }

    return modules;
  }

  Future<void> answerQuestion({
    required String childId,
    required String moduleId,
    required String questionId,
    required int answer,
  }) async {
    final moduleDocumentReference = _firestore
        .collection(childrenCollectionName)
        .doc(childId)
        .collection(modulesCollectionName)
        .doc(moduleId);

    final questionDocumentReference = moduleDocumentReference
        .collection(questionsCollectionName)
        .doc(questionId);

    await questionDocumentReference.update({
      answerField: answer,
    });
    await moduleDocumentReference.update({
      timestampField: FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Question>> childModuleQuestionsWithAnswerStream({
    required String childId,
    required String moduleId,
  }) =>
      _firestore
          .collection(childrenCollectionName)
          .doc(childId)
          .collection(modulesCollectionName)
          .doc(moduleId)
          .collection(questionsCollectionName)
          .where(
            answerField,
          )
          .withConverter(
            fromFirestore: (documentSnapshot, _) =>
                Question.fromJson(documentSnapshot.data()!),
            toFirestore: (question, _) => question.toJson(),
          )
          .snapshots();
}
