import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client_delivery_app/src/bloc/item/item_event.dart';
import 'package:client_delivery_app/src/bloc/item/item_state.dart';
import 'package:client_delivery_app/src/model/item.dart';
import 'package:client_delivery_app/src/repository/item_repository.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository _itemRepository;

  ItemBloc({ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(null);

  @override
  Stream<ItemState> mapEventToState(
    ItemEvent event,
  ) async* {
    if (event is AddItem) {
      yield* _mapAddItemToState(event);
    } else if (event is ListItem) {
      yield* _mapListItemToState();
    }
  }

  Stream<ItemState> _mapAddItemToState(AddItem event) async* {
    yield ItemLoading();
    try {
      final response = await _itemRepository.add(event);
      if (response.isSuccess) {
        yield ItemSuccess();
      } else {
        yield ItemFailed(response.message);
      }
    } catch (e) {
      ItemFailed();
    }
  }

  Stream<ItemState> _mapListItemToState() async* {
    yield ListItemLoading();
    try {
      final List<Item> list = await _itemRepository.list();
      yield ListItemSuccess(list);
    } catch (e) {
      yield ListItemFailed();
    }
  }
}
