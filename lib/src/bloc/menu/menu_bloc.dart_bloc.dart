import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client_delivery_app/src/bloc/menu/menu_event.dart_event.dart';
import 'package:client_delivery_app/src/bloc/menu/menu_state.dart';
import 'package:client_delivery_app/src/model/menu.dart';
import 'package:client_delivery_app/src/repository/menu_repository.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepository _menuRepository;

  MenuBloc({MenuRepository menuRepository})
      : _menuRepository = menuRepository,
        super(null);

  @override
  Stream<MenuState> mapEventToState(
    MenuEvent event,
  ) async* {
    if (event is AddMenu) {
      yield* _mapAddMenuToState(event);
    } else if (event is ListMenu) {
      yield* _mapListMenuToState();
    }
  }

  Stream<MenuState> _mapAddMenuToState(AddMenu event) async* {
    yield MenuLoading();
    try {
      final response = await _menuRepository.add(event);
      if (response.isSuccess) {
        yield MenuSuccess();
      } else {
        yield MenuFailed(response.message);
      }
    } catch (e) {
      MenuFailed();
    }
  }

  Stream<MenuState> _mapListMenuToState() async* {
    yield ListMenuLoading();
    try {
      final List<Menu> list = await _menuRepository.list();
      yield ListMenuSuccess(list);
    } catch (e) {
      yield ListMenuFailed();
    }
  }
}
