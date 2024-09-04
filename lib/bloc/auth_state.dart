// import 'package:equatable/equatable.dart';

// abstract class AuthState extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class AuthInitial extends AuthState {}

// class AuthLoading extends AuthState {}


// class AuthSuccess extends AuthState {}

// class AuthFailure extends AuthState {
//   final String message;

//   AuthFailure(this.message);

//   @override
//   List<Object> get props => [message];
// }

// auth_state.dart
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

  

class AuthSignInSuccess extends AuthState {
  final bool isSignUp;

  const AuthSignInSuccess({required this.isSignUp});

  @override
  List<Object> get props => [isSignUp];
}

class AuthSignUpSuccess extends AuthState {
}

class AuthError extends AuthState {
  final String error;

  const AuthError(this.error);

  @override
  List<Object?> get props => [error];
}

class AuthPageState extends AuthState {
  final bool showLoginPage;

  const AuthPageState({required this.showLoginPage});

  @override
  List<Object?> get props => [showLoginPage];
}
