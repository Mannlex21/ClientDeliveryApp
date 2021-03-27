import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationLoad extends RegistrationEvent {}

class CompanyTypeLoad extends RegistrationEvent {}

class RegisterEmailChanged extends RegistrationEvent {
  final String email;

  RegisterEmailChanged({this.email});

  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends RegistrationEvent {
  final String password;

  RegisterPasswordChanged({this.password});

  @override
  List<Object> get props => [password];
}

class AddRegistration extends RegistrationEvent {
  final String company;
  final String companyAddress;
  final String floorOffice;
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String companyType;
  final String id;

  const AddRegistration(
    this.company,
    this.companyAddress,
    this.floorOffice,
    this.name,
    this.lastName,
    this.email,
    this.password,
    this.phoneNumber,
    this.companyType,
    this.id,
  );

  @override
  List<Object> get props => [
        company,
        companyAddress,
        floorOffice,
        name,
        lastName,
        email,
        password,
        phoneNumber,
        companyType,
        id,
      ];

  @override
  String toString() => 'Adding registration';
}
