import 'package:client_delivery_app/src/model/item.dart';
import 'package:equatable/equatable.dart';

class ItemState extends Equatable {
  final List listItem;
  ItemState({this.listItem});

  @override
  List<Object> get props => (listItem);
}

class ItemLoading extends ItemState {
  @override
  String toString() => 'Loading';
}

class ItemSuccess extends ItemState {
  @override
  String toString() => 'Loaded';
}

class ItemFailed extends ItemState {
  final String message;

  ItemFailed([this.message]);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'No loaded';
}

class ListItemLoading extends ItemState {
  @override
  String toString() => 'Loading';
}

class ListItemSuccess extends ItemState {
  final List<Item> listItem;

  ListItemSuccess([this.listItem]);

  @override
  List<Object> get props => [listItem];

  @override
  String toString() => 'Loaded';
}

class ListItemFailed extends ItemState {
  final String message;

  ListItemFailed([this.message]);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'No loaded';
}
