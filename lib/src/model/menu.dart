import 'package:client_delivery_app/src/model/itemModifier.dart';

class Menu {
  String _title;
  List<ItemModifier> _list;
  String _id;

  Menu(this._title, this._list, this._id);

  set title(String title) {
    this._title = title;
  }

  set list(List<ItemModifier> list) {
    this._list = list;
  }

  set id(String id) {
    this._id = id;
  }

  String get title => this._title;
  List<ItemModifier> get list => this._list;
  String get id => this._id;

  Menu.fromMap(Map<String, dynamic> data) {
    title = data['title'];
    list = data['list'];
    id = data['id'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'list': list.map((i) => i.toMap()).toList(),
    };
  }
}
