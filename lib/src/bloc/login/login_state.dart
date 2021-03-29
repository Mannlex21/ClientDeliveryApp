import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable {
  final List propss;
  LoginState([this.propss]);

  @override
  List<Object> get props => (propss ?? []);
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'Loading';
}

class LoginSuccess extends LoginState {
  final User currentUser;

  LoginSuccess([this.currentUser]);

  @override
  List<Object> get props => [currentUser];

  @override
  String toString() => 'Loaded';
}

class LoginFailed extends LoginState {
  final String message;

  LoginFailed([this.message]);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Failure';
}
