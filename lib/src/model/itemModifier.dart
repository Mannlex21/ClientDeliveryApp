class ItemModifier {
  String _name;
  double _price;
  String _id;

  ItemModifier(this._name, this._price, this._id);

  set name(String name) {
    this._name = name;
  }

  set price(double price) {
    this._price = price;
  }

  set id(String id) {
    this._id = id;
  }

  String get name => this._name;
  double get price => this._price;
  String get id => this._id;

  ItemModifier.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    price = data['price'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }
}
