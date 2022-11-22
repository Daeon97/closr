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

  Stream<QuerySnapshot<Child>> get children => _firestore
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

  Stream<DocumentSnapshot<Child>> childDetails(
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

  Future<QuerySnapshot<Module>> get modules => _firestore
      .collection(modulesCollectionName)
      .withConverter(
        fromFirestore: (documentSnapshot, _) =>
            Module.fromJson(documentSnapshot.data()!),
        toFirestore: (module, _) => module.toJson(),
      )
      .get();
}
