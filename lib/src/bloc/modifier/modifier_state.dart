import 'package:equatable/equatable.dart';

class ModifierState extends Equatable {
  final List modifierList;
  ModifierState({this.modifierList});

  ModifierState modifyList({String name, String price}) {
    modifierList.add({'name': name, 'price': price});

    return ModifierState(modifierList: modifierList ?? this.modifierList);
  }

  @override
  List<Object> get props => (modifierList);
}

class ModifierLoading extends ModifierState {
  @override
  String toString() => 'Loading';
}

class ModifierSuccess extends ModifierState {
  @override
  String toString() => 'Loaded';
}

class RegistrationFailed extends ModifierState {
  final String message;

  RegistrationFailed([this.message]);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'No loaded';
}
