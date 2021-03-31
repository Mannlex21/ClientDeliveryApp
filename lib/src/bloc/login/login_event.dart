import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Authentication extends LoginEvent {
  final String email;
  final String password;

  Authentication({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthenticationLoggedIn extends LoginEvent {
  final User user;

  AuthenticationLoggedIn({this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationLoggedOut extends LoginEvent {}
