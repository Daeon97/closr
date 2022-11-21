import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../repos/repos.dart';
import '../../utils/utils.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  StreamSubscription<User?>? _userChangesStreamSubscription;
  final AuthRepo _authRepo;

  AuthCubit(
    this._authRepo,
  ) : super(
          const AuthInitialState(),
        );

  void signIn({
    required String email,
    required String password,
  }) async {
    emit(
      const AuthenticatingState(),
    );
    try {
      await _authRepo.signIn(
        email: email,
        password: password,
      );
      emit(
        const AuthenticatedState(
          homeScreenRoute,
        ),
      );
    } on FirebaseAuthException catch (e) {
      _unAuthenticateUser(
        errorMessage: e.message ?? anErrorOccurredText,
      );
    } catch (_) {
      _unAuthenticateUser(
        errorMessage: anErrorOccurredText,
      );
    }
  }

  void listenUserChanges() async {
    if (_userChangesStreamSubscription != null) {
      await _userChangesStreamSubscription!.cancel();
      _userChangesStreamSubscription = null;
    }
    _userChangesStreamSubscription = _authRepo.userChanges.listen(
      (user) {
        if (user == null) {
          _unAuthenticateUser(
            route: defaultScreenRoute,
          );
        }
      },
    );
  }

  User? get currentUser => _authRepo.currentUser;

  Future<void> signOut() => _authRepo.signOut();

  void stopListeningUserChanges() async {
    if (_userChangesStreamSubscription != null) {
      await _userChangesStreamSubscription!.cancel();
      _userChangesStreamSubscription = null;
    }
  }

  void signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(
      const AuthenticatingState(),
    );
    try {
      await _authRepo.signUp(
        name: name,
        email: email,
        password: password,
      );
      emit(
        const AuthenticatedState(
          homeScreenRoute,
        ),
      );
    } on FirebaseAuthException catch (e) {
      _unAuthenticateUser(
        errorMessage: e.message ?? anErrorOccurredText,
      );
    } catch (_) {
      _unAuthenticateUser(
        errorMessage: anErrorOccurredText,
      );
    }
  }

  void _unAuthenticateUser({
    String? errorMessage,
    String? route,
  }) {
    emit(
      UnAuthenticatedState(
        errorMessage: errorMessage,
        route: route,
      ),
    );
  }
}
