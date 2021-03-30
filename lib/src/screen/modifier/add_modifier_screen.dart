import 'package:client_delivery_app/src/bloc/modifier/modifier_bloc.dart';
import 'package:client_delivery_app/src/bloc/modifier/modifier_event.dart';
import 'package:client_delivery_app/src/bloc/modifier/modifier_state.dart';
import 'package:client_delivery_app/src/model/itemModifier.dart';
import 'package:client_delivery_app/src/model/modifier.dart';
import 'package:client_delivery_app/src/repository/modifier_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddModifierScreen extends StatefulWidget {
  final BuildContext context;
  AddModifierScreen(this.context, {Key key}) : super(key: key);

  @override
  _AddModifierScreenState createState() => _AddModifierScreenState();
}

class _AddModifierScreenState extends State<AddModifierScreen> {
  final ModifierRepository _modifierRepository = ModifierRepository();
  List<ItemModifier> modifierList = [];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();

  String title = "";
  bool isOptional = false;

  FocusNode titleFocus;
  ModifierBloc _modifierBloc;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ModifierBloc, ModifierState>(
      listener: (context, state) {
        if (state is ModifierSuccess) {
          Navigator.of(context).pop(false);
        }
      },
      child: BlocBuilder<ModifierBloc, ModifierState>(builder: (context, state) {
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
                  _modifierBloc.add(AddModifier(Modifier(_titleController.text, modifierList, null)));
                },
                child: Center(
                  child: Text('Guardar modificador'),
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
                        "Grupo de modificadores",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Title:"),
                        controller: _titleController,
                        focusNode: titleFocus,
                        keyboardType: TextInputType.name,
                        // onEditingComplete: () => requestFocus(context, passwordFocus),
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          title = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Este campo es obligatorio";
                          }

                          return null;
                        },
                      ),
                      CheckboxListTile(
                        title: Text("Se requiere que los clientes elijan modificadores"),
                        value: isOptional,
                        onChanged: (newValue) {
                          setState(() {
                            isOptional = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: Text("Establecer número total de modificadores que los clientes pueden elegir"),
                        value: isOptional,
                        onChanged: (newValue) {
                          setState(() {
                            isOptional = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: Text("Establecer número total de modificadores que los clientes pueden elegir"),
                        value: isOptional,
                        onChanged: (newValue) {
                          setState(() {
                            isOptional = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                      ),
                      ElevatedButton(onPressed: () => openDialog(context), child: Text("Agregar modificador")),
                      Column(
                        children: [
                          for (ItemModifier item in modifierList) itemModifier(context, item),
                        ],
                      )
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

  Widget itemModifier(BuildContext context, ItemModifier item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.name,
              style: TextStyle(fontSize: 18),
            ),
            Container(
              child: Row(
                children: [
                  Text(
                    item.price.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.more_vert)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  openDialog(BuildContext context) {
    GlobalKey<FormState> _formDialogKey = GlobalKey<FormState>();
    String name = '';
    String price = '';
    TextEditingController _nameController = TextEditingController();
    TextEditingController _priceController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Setting String"),
          content: Container(
            height: 170,
            child: Form(
              key: _formDialogKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Nombre"),
                    controller: _nameController,
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
                    decoration: InputDecoration(labelText: "Precio"),
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      price = value;
                    },
                    validator: (value) {
                      RegExp reg = RegExp(
                        r"^(-?)(0|([1-9][0-9]*))(\\.[0-9]+)?$",
                      );

                      if (value.isEmpty) {
                        return "Este campo es obligatorio";
                      }

                      if (!reg.hasMatch(value)) {
                        return "Debe ser doble";
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context, null);
              },
            ),
            ElevatedButton(
              child: Text("Agregar"),
              onPressed: () {
                if (_formDialogKey.currentState.validate()) {
                  Navigator.pop(context, {'name': _nameController.text, 'price': _priceController.text});
                }
              },
            ),
          ],
        );
      },
      barrierDismissible: false,
    ).then((value) {
      if (value != null) {
        modifierList.add(ItemModifier(value['name'], double.parse(value['price']), null));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _modifierBloc.close();
  }

  @override
  void initState() {
    super.initState();
    _modifierBloc = BlocProvider.of<ModifierBloc>(context);
  }
}
