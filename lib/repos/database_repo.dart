import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseRepo {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  DatabaseRepo()
      : _auth = FirebaseAuth.instance,
        _firestore = FirebaseFirestore.instance;
}
