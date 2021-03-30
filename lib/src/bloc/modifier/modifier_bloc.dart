import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client_delivery_app/src/bloc/modifier/modifier_event.dart';
import 'package:client_delivery_app/src/bloc/modifier/modifier_state.dart';
import 'package:client_delivery_app/src/repository/modifier_repository.dart';

class ModifierBloc extends Bloc<ModifierEvent, ModifierState> {
  final ModifierRepository _modifierRepository;

  ModifierBloc({ModifierRepository modifierRepository})
      : _modifierRepository = modifierRepository,
        super(null);

  @override
  Stream<ModifierState> mapEventToState(
    ModifierEvent event,
  ) async* {
    if (event is AddModifier) {
      yield* _mapAddModifierToState(event);
    }
  }

  Stream<ModifierState> _mapAddModifierToState(AddModifier event) async* {
    yield ModifierLoading();
    try {
      final response = await _modifierRepository.addModifier(event);
      if (response.isSuccess) {
        yield ModifierSuccess();
      } else {
        yield RegistrationFailed(response.message);
      }
    } catch (e) {
      RegistrationFailed();
    }
  }
}
