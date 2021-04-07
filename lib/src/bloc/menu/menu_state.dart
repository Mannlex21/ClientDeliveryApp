import 'package:client_delivery_app/src/model/menu.dart';
import 'package:equatable/equatable.dart';

class MenuState extends Equatable {
  final List listModifier;
  MenuState({this.listModifier});

  @override
  List<Object> get props => (listModifier);
}

class MenuLoading extends MenuState {
  @override
  String toString() => 'Loading';
}

class MenuSuccess extends MenuState {
  @override
  String toString() => 'Loaded';
}

class MenuFailed extends MenuState {
  final String message;

  MenuFailed([this.message]);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'No loaded';
}

class ListMenuLoading extends MenuState {
  @override
  String toString() => 'Loading';
}

class ListMenuSuccess extends MenuState {
  final List<Menu> listMenu;

  ListMenuSuccess([this.listMenu]);

  @override
  List<Object> get props => [listMenu];

  @override
  String toString() => 'Loaded';
}

class ListMenuFailed extends MenuState {
  final String message;

  ListMenuFailed([this.message]);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'No loaded';
}
