import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth;

  AuthRepo() : _auth = FirebaseAuth.instance;

  Future<void> signIn({
    required String email,
    required String password,
  }) =>
      _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<void> signUp({
    required String email,
    required String password,
  }) =>
      _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  User? get currentUser => _auth.currentUser;

  Stream<User?> get userChanges => _auth.userChanges();
}
