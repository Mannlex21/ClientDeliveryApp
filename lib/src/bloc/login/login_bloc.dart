import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:client_delivery_app/src/bloc/login/login_event.dart';
import 'package:client_delivery_app/src/bloc/login/login_state.dart';
import 'package:client_delivery_app/src/repository/login_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;

  LoginBloc({LoginRepository loginRepository})
      : _loginRepository = loginRepository,
        super(null);

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is Authentication) {
      yield* _mapAuthenticationToState(event);
    } else if (event is AuthenticationLoggedIn) {
      yield* _mapUserState();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  //AuthenticationLoggedOut
  Stream<LoginState> _mapLoggedOutToState() async* {
    yield LoginFailed();
    _loginRepository.signOut();
  }

  //AuthenticationLoggedIn
  Stream<LoginState> _mapUserState() async* {
    yield LoginSuccess(_loginRepository.getUser());
  }

  Stream<LoginState> _mapAuthenticationToState(Authentication event) async* {
    yield LoginLoading();
    try {
      final response = await _loginRepository.authentication(event);
      if (response.isSuccess) {
        final firebaseUser = _loginRepository.getUser();
        yield LoginSuccess(firebaseUser);
      } else {
        yield LoginFailed(response.message);
      }
    } catch (e) {
      yield LoginFailed();
    }
  }
}
