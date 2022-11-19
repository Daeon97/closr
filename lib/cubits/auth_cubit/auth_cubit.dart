import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../repos/repos.dart';
import '../../utils/utils.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(
    this.authRepo,
  ) : super(
          const AuthInitialState(),
        );

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(
      const AuthenticatingState(),
    );
    try {
      await authRepo.signIn(
        email: email,
        password: password,
      );
      emit(
        const AuthenticatedState(
          homeScreenRoute,
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        UnAuthenticatedState(
          errorMessage: e.message ?? anErrorOccurredText,
        ),
      );
    } catch (_) {
      emit(
        const UnAuthenticatedState(
          errorMessage: anErrorOccurredText,
        ),
      );
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(
      const AuthenticatingState(),
    );
    try {
      await authRepo.signUp(
        email: email,
        password: password,
      );
      emit(
        const AuthenticatedState(
          homeScreenRoute,
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        UnAuthenticatedState(
          errorMessage: e.message ?? anErrorOccurredText,
        ),
      );
    } catch (_) {
      emit(
        const UnAuthenticatedState(
          errorMessage: anErrorOccurredText,
        ),
      );
    }
  }
}
