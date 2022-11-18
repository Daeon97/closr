import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth;

  AuthRepo() : _auth = FirebaseAuth.instance;
}
