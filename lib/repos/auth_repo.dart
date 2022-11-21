import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth;

  AuthRepo() : _auth = FirebaseAuth.instance;

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) =>
      _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
  }) =>
      _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (userCredential) async {
          await userCredential.user!.updateDisplayName(
            name,
          );
          return userCredential;
        },
      );

  User? get currentUser => _auth.currentUser;

  Stream<User?> get userChanges => _auth.userChanges();

  Future<void> signOut() => _auth.signOut();
}
