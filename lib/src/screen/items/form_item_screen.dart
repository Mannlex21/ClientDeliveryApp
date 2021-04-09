import 'package:client_delivery_app/src/bloc/item/item_bloc.dart';
import 'package:client_delivery_app/src/bloc/item/item_event.dart';
import 'package:client_delivery_app/src/bloc/item/item_state.dart';
import 'package:client_delivery_app/src/model/item.dart';
import 'package:client_delivery_app/src/model/modifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormItemScreen extends StatefulWidget {
  final BuildContext context;
  final Modifier modifier;
  FormItemScreen(this.context, {Key key, this.modifier}) : super(key: key);

  @override
  _FormItemScreenState createState() => _FormItemScreenState();
}

class _FormItemScreenState extends State<FormItemScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _menuController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _usedInController = TextEditingController();
  TextEditingController _containController = TextEditingController();
  TextEditingController _lastUpdateController = TextEditingController();

  String name;
  double price;
  List<String> menu;
  List<String> category;
  List<String> usedIn;
  List<String> contain;
  DateTime lastUpdate;
  bool isOutOfStock = false;
  bool isSellingItself = true;

  FocusNode titleFocus;
  FocusNode priceFocus;
  FocusNode menuFocus;
  FocusNode categoryFocus;
  FocusNode usedInFocus;
  FocusNode containFocus;
  FocusNode lastUpdateFocus;
  FocusNode isOutOfStockFocus;
  FocusNode isSellingItselfFocus;

  ItemBloc _itemBloc;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemBloc, ItemState>(
      listener: (context, state) {
        if (state is ItemSuccess) {
          Navigator.of(context).pushReplacementNamed('/menu');
        }
      },
      child: BlocBuilder<ItemBloc, ItemState>(builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Container(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
                ),
                onPressed: () {
                  _itemBloc.add(AddItem(Item(
                      _nameController.text,
                      double.parse(_priceController.text),
                      [_menuController.text],
                      [_categoryController.text],
                      [_usedInController.text],
                      [_containController.text],
                      DateTime.now(),
                      isOutOfStock,
                      isSellingItself)));
                },
                child: Center(
                  child: Text('Guardar'),
                ),
              ),
            ),
          ),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: Container(),
                  ),
                  expandedHeight: 71,
                  pinned: true,
                  collapsedHeight: 71,
                  toolbarHeight: 70,
                  elevation: 1,
                  backgroundColor: Colors.white,
                ),
              ];
            },
            body: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Articulo",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Nombre:"),
                        controller: _nameController,
                        focusNode: titleFocus,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          name = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Este campo es obligatorio";
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Precio:"),
                        controller: _priceController,
                        focusNode: priceFocus,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          price = double.parse(value);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Este campo es obligatorio";
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Menu:"),
                        controller: _menuController,
                        focusNode: menuFocus,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          menu = [value];
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Este campo es obligatorio";
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Categoria:"),
                        controller: _categoryController,
                        focusNode: categoryFocus,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          category = [value];
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Este campo es obligatorio";
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Usado en:"),
                        controller: _usedInController,
                        focusNode: usedInFocus,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          usedIn = [value];
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Este campo es obligatorio";
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Contiene:"),
                        controller: _containController,
                        focusNode: containFocus,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          contain = [value];
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Este campo es obligatorio";
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Ultima actualización:"),
                        controller: _lastUpdateController,
                        focusNode: lastUpdateFocus,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          lastUpdate = DateTime.now();
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Este campo es obligatorio";
                          }

                          return null;
                        },
                      ),
                      CheckboxListTile(
                        title: Text("¿Esta fuera de Stock?"),
                        value: isOutOfStock,
                        onChanged: (newValue) {
                          setState(() {
                            isOutOfStock = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: Text("¿Se vende individualmente?"),
                        value: isSellingItself,
                        onChanged: (newValue) {
                          setState(() {
                            isSellingItself = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    this._nameController.dispose();
    this._priceController.dispose();

    _itemBloc.close();
  }

  @override
  void initState() {
    super.initState();
    _itemBloc = BlocProvider.of<ItemBloc>(context);
  }
}
