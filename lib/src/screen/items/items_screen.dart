import 'package:client_delivery_app/src/bloc/item/item_bloc.dart';
import 'package:client_delivery_app/src/bloc/item/item_state.dart';
import 'package:client_delivery_app/src/components/item/list_item_widget.dart';
import 'package:client_delivery_app/src/model/item.dart';
import 'package:client_delivery_app/src/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsScreen extends StatefulWidget {
  final BuildContext context;
  ItemsScreen(this.context, {Key key}) : super(key: key);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  ItemBloc _itemBloc;
  List<Item> listItem = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemBloc, ItemState>(
      listener: (context, state) {
        if (state is ListItemSuccess) {
          setState(() {
            listItem = state.listItem;
          });
        }
      },
      child: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xff03dac6),
              foregroundColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pushNamed('/form_item', arguments: null);
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
                  child: ListItemWidget(listItem: listItem),
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
    _itemBloc.close();
  }

  @override
  void initState() {
    super.initState();
    _itemBloc = BlocProvider.of<ItemBloc>(context);
  }
}
