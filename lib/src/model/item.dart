class Item {
  String _name;
  double _price;
  List<String> _menus;
  List<String> _categories;
  List<String> _usedIn;
  List<String> _contains;
  DateTime _lastUpdate;
  bool _isOutOfStock;
  bool _isSellingItself; // si quieres vender el articulo de forma independiente

  Item(this._name, this._price, this._menus, this._categories, this._usedIn, this._contains, this._lastUpdate, this._isOutOfStock,
      this._isSellingItself);

  set name(String name) {
    this._name = name;
  }

  set price(double price) {
    this._price = price;
  }

  set menus(List<String> menus) {
    this._menus = menus;
  }

  set categories(List<String> categories) {
    this._categories = categories;
  }

  set usedIn(List<String> usedIn) {
    this._usedIn = usedIn;
  }

  set contains(List<String> contains) {
    this._contains = contains;
  }

  set lastUpdate(DateTime lastUpdate) {
    this._lastUpdate = lastUpdate;
  }

  set isOutOfStock(bool isOutOfStock) {
    this._isOutOfStock = isOutOfStock;
  }

  set isSellingItself(bool isSellingItself) {
    this._isSellingItself = isSellingItself;
  }

  String get name => this._name;
  double get price => this._price;
  List<String> get menus => this._menus;
  List<String> get categories => this._categories;
  List<String> get usedIn => this._usedIn;
  List<String> get contains => this._contains;
  DateTime get lastUpdate => this._lastUpdate;
  bool get isOutOfStock => this._isOutOfStock;
  bool get isSellingItself => this._isSellingItself;

  Item.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    price = data['price'];
    menus = data['menus'];
    categories = data['categories'];
    usedIn = data['usedIn'];
    contains = data['contains'];
    lastUpdate = data['lastUpdate'];
    isOutOfStock = data['isOutOfStock'];
    isSellingItself = data['isSellingItself'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'menus': menus.map((i) => i).toList(),
      'categories': categories.map((i) => i).toList(), // cuandon tenga clase propia se usa i.toMap()
      'usedIn': usedIn.map((i) => i).toList(),
      'contains': contains.map((i) => i).toList(),
      'lastUpdate': lastUpdate,
      'isOutOfStock': isOutOfStock,
      'isSellingItself': isSellingItself,
    };
  }
}
