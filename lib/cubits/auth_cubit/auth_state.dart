part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();

  @override
  List<Object?> get props => [];
}

class AuthenticatingState extends AuthState {
  const AuthenticatingState();

  @override
  List<Object?> get props => [];
}

class AuthenticatedState extends AuthState {
  final String route;

  const AuthenticatedState(
    this.route,
  );

  @override
  List<Object?> get props => [
        route,
      ];
}

class UnAuthenticatedState extends AuthState {
  final String? errorMessage;
  final String? route;

  const UnAuthenticatedState({
    this.errorMessage,
    this.route,
  });

  @override
  List<Object?> get props => [
        errorMessage,
        route,
      ];
}
