import 'package:client_delivery_app/src/bloc/modifier/modifier_bloc.dart';
import 'package:client_delivery_app/src/bloc/modifier/modifier_state.dart';
import 'package:client_delivery_app/src/components/modifier/list_modifier_widget.dart';
import 'package:client_delivery_app/src/model/modifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModifierScreen extends StatefulWidget {
  final BuildContext context;
  ModifierScreen(this.context, {Key key}) : super(key: key);

  @override
  _ModifierScreenState createState() => _ModifierScreenState();
}

class _ModifierScreenState extends State<ModifierScreen> {
  ModifierBloc _modifierBloc;
  List<Modifier> listModifier = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<ModifierBloc, ModifierState>(
      listener: (context, state) {
        if (state is ListModifierSuccess) {
          print('entro');
          setState(() {
            listModifier = state.listModifier;
          });
        }
      },
      child: BlocBuilder<ModifierBloc, ModifierState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xff03dac6),
              foregroundColor: Colors.black,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/form_modifier', arguments: null);
              },
              child: Icon(Icons.add),
            ),
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
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
                child: Container(
                  child: ListModifierWidget(listModifier: listModifier),
                ),
              ),
            ),
          );
        },
      ),
    );
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
