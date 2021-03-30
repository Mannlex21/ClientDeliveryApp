import 'package:client_delivery_app/src/model/modifier.dart';
import 'package:equatable/equatable.dart';

class ModifierState extends Equatable {
  final List listModifier;
  ModifierState({this.listModifier});

  @override
  List<Object> get props => (listModifier);
}

class ModifierLoading extends ModifierState {
  @override
  String toString() => 'Loading';
}

class ModifierSuccess extends ModifierState {
  @override
  String toString() => 'Loaded';
}

class ModifierFailed extends ModifierState {
  final String message;

  ModifierFailed([this.message]);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'No loaded';
}

class ListModifierLoading extends ModifierState {
  @override
  String toString() => 'Loading';
}

class ListModifierSuccess extends ModifierState {
  final List<Modifier> listModifier;

  ListModifierSuccess([this.listModifier]);

  @override
  List<Object> get props => [listModifier];

  @override
  String toString() => 'Loaded';
}

class ListModifierFailed extends ModifierState {
  final String message;

  ListModifierFailed([this.message]);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'No loaded';
}
