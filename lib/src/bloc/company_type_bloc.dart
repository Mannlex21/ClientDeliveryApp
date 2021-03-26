import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client_delivery_app/src/bloc/company_type_state.dart';
import 'package:client_delivery_app/src/bloc/company_type_event.dart';
import 'package:client_delivery_app/src/model/CompanyType.dart';
import 'package:client_delivery_app/src/repository/company_type_repository.dart';

class CompanyTypeBloc extends Bloc<CompanyTypeEvent, CompanyTypeState> {
  final CompanyTypeRepository _companyTypeRepository;

  CompanyTypeBloc({CompanyTypeRepository companyTypeRepository})
      : _companyTypeRepository = companyTypeRepository,
        super(null);

  @override
  CompanyTypeState get initialState => CompanyTypeLoading();

  @override
  Stream<CompanyTypeState> mapEventToState(CompanyTypeEvent event) async* {
    if (event is CompanyTypeLoad) {
      yield* _mapLoadCompanyTypeToState();
    }
  }

  Stream<CompanyTypeState> _mapLoadCompanyTypeToState() async* {
    yield CompanyTypeLoading();
    try {
      final List<CompanyType> list = await _companyTypeRepository.getList().first;
      yield CompanyTypeLoaded(list);
    } catch (_) {
      yield CompanyTypeNoLoaded();
    }
  }
  // final _listCompanyTypeStreamController = StreamController<List<CompanyType>>();

  // Stream<List<CompanyType>> get companyListStream => _listCompanyTypeStreamController.stream;

  // CompanyTypeBloc() {
  //   _listCompanyTypeStreamController.add(_list);
  // }

  // void close() {
  //   _listCompanyTypeStreamController.close();
  // }
}
