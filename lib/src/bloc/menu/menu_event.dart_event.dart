import 'package:client_delivery_app/src/model/menu.dart';
import 'package:equatable/equatable.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class AddMenu extends MenuEvent {
  final Menu menu;

  const AddMenu(
    this.menu,
  );

  @override
  List<Object> get props => [menu];

  @override
  String toString() => 'Adding modifier';
}

class ListMenu extends MenuEvent {
  @override
  String toString() => 'Adding modifier';
}
