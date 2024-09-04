// import 'package:equatable/equatable.dart';

// abstract class AuthEvent extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class SignInRequested extends AuthEvent {
//   final String email;
//   final String password;

//   SignInRequested(this.email, this.password);

//   @override
//   List<Object> get props => [email, password];
// }

// class SignUpRequested extends AuthEvent {
//   final String email;
//   final String password;

//   SignUpRequested(this.email, this.password);

//   @override
//   List<Object> get props => [email, password];
// }

// auth_event.dart
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String firstname;
  final String age;

  const SignUpRequested(this.email, this.password, this.firstname,this.age);

  @override
  List<Object?> get props => [email, password, firstname , age];
}

class ToggleAuthPage extends AuthEvent {}
