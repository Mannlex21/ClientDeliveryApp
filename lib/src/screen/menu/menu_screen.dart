import 'package:client_delivery_app/src/bloc/menu/menu_bloc.dart_bloc.dart';
import 'package:client_delivery_app/src/bloc/menu/menu_state.dart';
import 'package:client_delivery_app/src/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatefulWidget {
  final BuildContext context;
  MenuScreen(this.context, {Key key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MenuBloc, MenuState>(
      listener: (context, state) {
        if (state is ListMenuSuccess) {}
      },
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xff03dac6),
              foregroundColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pushNamed('/form_menu', arguments: null);
              },
              child: Icon(Icons.add),
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
                        Navigator.pushAndRemoveUntil(
                          context,
                          new MaterialPageRoute(builder: (BuildContext context) => MyHomeScreen()),
                          (Route<dynamic> route) => false,
                        );
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
                  child: null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
