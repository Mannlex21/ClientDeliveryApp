import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client_delivery_app/src/bloc/modifier/modifier_event.dart';
import 'package:client_delivery_app/src/bloc/modifier/modifier_state.dart';
import 'package:client_delivery_app/src/model/modifier.dart';
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
    } else if (event is ListModifier) {
      yield* _mapListModifierToState();
    }
  }

  Stream<ModifierState> _mapAddModifierToState(AddModifier event) async* {
    yield ModifierLoading();
    try {
      final response = await _modifierRepository.add(event);
      if (response.isSuccess) {
        yield ModifierSuccess();
      } else {
        yield ModifierFailed(response.message);
      }
    } catch (e) {
      ModifierFailed();
    }
  }

  Stream<ModifierState> _mapListModifierToState() async* {
    yield ListModifierLoading();
    try {
      final List<Modifier> list = await _modifierRepository.list();
      yield ListModifierSuccess(list);
    } catch (e) {
      yield ListModifierFailed();
    }
  }
}
