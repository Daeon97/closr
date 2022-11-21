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
      _firestore
          .collection(parentsCollectionName)
          .doc(
            _auth.currentUser!.uid,
          )
          .collection(childrenCollectionName)
          .doc()
          .set({
        nameField: name,
        ageField: age,
        genderField: gender,
        classField: mClass,
      });

  Stream<QuerySnapshot<Child>> get children => _firestore
      .collection(parentsCollectionName)
      .doc(
        _auth.currentUser!.uid,
      )
      .collection(childrenCollectionName)
      .withConverter<Child>(
        fromFirestore: (documentSnapshot, _) => Child.fromJson(
          documentSnapshot.data()!,
        ),
        toFirestore: (child, _) => child.toJson(),
      )
      .snapshots();
}
