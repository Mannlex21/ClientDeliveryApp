class ItemModifier {
  String _name;
  double _price;

  ItemModifier(this._name, this._price);

  set name(String name) {
    this._name = name;
  }

  set price(double price) {
    this._price = price;
  }

  String get name => this._name;
  double get price => this._price;

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
