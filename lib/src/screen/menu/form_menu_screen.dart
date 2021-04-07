import 'package:client_delivery_app/src/bloc/modifier/modifier_bloc.dart';
import 'package:client_delivery_app/src/bloc/modifier/modifier_state.dart';
import 'package:client_delivery_app/src/model/itemModifier.dart';
import 'package:client_delivery_app/src/model/modifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormMenuScreen extends StatefulWidget {
  final BuildContext context;
  final Modifier modifier;
  FormMenuScreen(this.context, {Key key, this.modifier}) : super(key: key);

  @override
  _FormMenuScreenState createState() => _FormMenuScreenState();
}

class _FormMenuScreenState extends State<FormMenuScreen> {
  List<ItemModifier> modifierList = [];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  String title = "";
  String name = '';
  String price = '';
  bool isOptional = false;

  FocusNode titleFocus;
  ModifierBloc _modifierBloc;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ModifierBloc, ModifierState>(
      listener: (context, state) {
        if (state is ModifierSuccess) {
          Navigator.of(context).pushReplacementNamed('/menu');
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
                onPressed: () {},
                child: Center(
                  child: Text('Food'),
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
                      ElevatedButton(
                          onPressed: () => {}, //openDialog(context),
                          child: Text("Agregar modificador")),
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
}
