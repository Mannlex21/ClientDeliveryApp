import 'package:equatable/equatable.dart';
import 'package:client_delivery_app/src/model/companyType.dart';

class RegistrationState extends Equatable {
  final bool isEmailValid;
  final bool isPasswordValid;
  const RegistrationState({this.isEmailValid, this.isPasswordValid});

  RegistrationState copyWith({bool isEmailValid, bool isPasswordValid}) {
    return RegistrationState(isEmailValid: isEmailValid ?? this.isEmailValid, isPasswordValid: isPasswordValid ?? this.isPasswordValid);
  }

  @override
  List<Object> get props => [isEmailValid, isPasswordValid];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {
  @override
  String toString() => 'Loading';
}

class RegistrationLoaded extends RegistrationState {
  final List<CompanyType> companyTypeList;

  const RegistrationLoaded([this.companyTypeList]);

  @override
  List<Object> get props => [companyTypeList];

  @override
  String toString() => 'Loaded';
}

class RegistrationNoLoaded extends RegistrationState {
  @override
  String toString() => 'No loaded';
}

class CompanyTypeLoading extends RegistrationState {
  @override
  String toString() => 'Loading';
}

class CompanyTypeLoaded extends RegistrationState {
  final List<CompanyType> companyTypeList;

  const CompanyTypeLoaded([this.companyTypeList]);

  @override
  List<Object> get props => [companyTypeList];

  @override
  String toString() => 'Loaded';
}

class CompanyTypeNoLoaded extends RegistrationState {
  @override
  String toString() => 'No loaded';
}
