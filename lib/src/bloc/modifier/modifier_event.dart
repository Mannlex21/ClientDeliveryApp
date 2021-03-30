import 'package:client_delivery_app/src/model/modifier.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ModifierEvent {
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
