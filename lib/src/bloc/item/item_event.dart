import 'package:client_delivery_app/src/model/item.dart';
import 'package:equatable/equatable.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class AddItem extends ItemEvent {
  final Item item;

  const AddItem(
    this.item,
  );

  @override
  List<Object> get props => [Item];

  @override
  String toString() => 'Adding Item';
}

class ListItem extends ItemEvent {
  @override
  String toString() => 'Adding Item';
}
