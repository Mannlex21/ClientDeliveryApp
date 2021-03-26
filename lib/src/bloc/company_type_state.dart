import 'package:client_delivery_app/src/model/CompanyType.dart';
import 'package:equatable/equatable.dart';

abstract class CompanyTypeState extends Equatable {
  const CompanyTypeState();

  @override
  List<Object> get props => [];
}

class CompanyTypeInitial extends CompanyTypeState {}

class CompanyTypeLoading extends CompanyTypeState {
  @override
  String toString() => 'Loading';
}

class CompanyTypeLoaded extends CompanyTypeState {
  final List<CompanyType> companyTypeList;

  const CompanyTypeLoaded([this.companyTypeList]);

  @override
  List<Object> get props => [companyTypeList];

  @override
  String toString() => 'Loaded';
}

class CompanyTypeNoLoaded extends CompanyTypeState {
  @override
  String toString() => 'No loaded';
}
