import 'package:client_delivery_app/src/model/modifier.dart';
import 'package:equatable/equatable.dart';

abstract class ModifierEvent extends Equatable {
  const ModifierEvent();

  @override
  List<Object> get props => [];
}

class AddModifier extends ModifierEvent {
  final Modifier modifier;

  const AddModifier(
    this.modifier,
  );

  @override
  List<Object> get props => [modifier];

  @override
  String toString() => 'Adding modifier';
}

class ListModifier extends ModifierEvent {
  @override
  String toString() => 'Adding modifier';
}
