import 'package:equatable/equatable.dart';

abstract class CompanyTypeEvent extends Equatable {
  const CompanyTypeEvent();

  @override
  List<Object> get props => [];
}

class CompanyTypeLoad extends CompanyTypeEvent {}
