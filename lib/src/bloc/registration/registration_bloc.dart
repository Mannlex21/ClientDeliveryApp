import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client_delivery_app/src/bloc/registration/registration_event.dart';
import 'package:client_delivery_app/src/bloc/registration/registration_state.dart';
import 'package:client_delivery_app/src/model/companyType.dart';
import 'package:client_delivery_app/src/repository/company_type_repository.dart';
import 'package:client_delivery_app/src/repository/registration_repository.dart';
import 'package:client_delivery_app/src/utils/validators.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepository _registrationRepository;
  final CompanyTypeRepository _companyTypeRepository;

  RegistrationBloc({RegistrationRepository registrationRepository, CompanyTypeRepository companyTypeRepository})
      : _registrationRepository = registrationRepository,
        _companyTypeRepository = companyTypeRepository,
        super(null);

  @override
  Stream<RegistrationState> mapEventToState(RegistrationEvent event) async* {
    if (event is AddRegistration) {
      yield* _mapAddCompanyToState(event);
    } else if (event is CompanyTypeLoad) {
      yield* _mapLoadCompanyTypeToState();
    } else if (event is RegisterEmailChanged) {
      yield state.copyWith(isEmailValid: _mapEmailChangeToState(event.email));
    } else if (event is RegisterPasswordChanged) {
      yield state.copyWith(isPasswordValid: _mapPasswordChangeToState(event.password));
    }
  }

  Stream<RegistrationState> _mapAddCompanyToState(AddRegistration event) async* {
    await _registrationRepository.post(event);
  }

  bool _mapEmailChangeToState(String email) {
    return Validators.isValidEmail(email);
  }

  bool _mapPasswordChangeToState(String email) {
    return Validators.isValidEmail(email);
  }

  Stream<RegistrationState> _mapLoadCompanyTypeToState() async* {
    yield CompanyTypeLoading();
    try {
      final List<CompanyType> list = await _companyTypeRepository.getList().first;
      yield CompanyTypeLoaded(list);
    } catch (_) {
      yield CompanyTypeNoLoaded();
    }
  }
}
