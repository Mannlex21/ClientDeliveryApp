import 'package:client_delivery_app/src/model/itemModifier.dart';

class Modifier {
  String _title;
  List<ItemModifier> _list;

  Modifier(this._title, this._list);

  set title(String title) {
    this._title = title;
  }

  set list(List<ItemModifier> list) {
    this._list = list;
  }

  String get title => this._title;
  List<ItemModifier> get list => this._list;

  Modifier.fromMap(Map<String, dynamic> data) {
    title = data['title'];
    list = data['list'];
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'list': list.map((i) => i.toMap()).toList(),
    };
  }
}
