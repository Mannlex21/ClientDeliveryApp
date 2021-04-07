import 'package:client_delivery_app/src/components/home/action_menu_widget.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: IconButton(
                          icon: Icon(Icons.notifications),
                          onPressed: () {},
                        ),
                      )
                    ],
                  )
                ],
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
          child: actions(),
        ),
      ),
    );
  }

  Widget actions() {
    return Container(
      color: Colors.white,
      height: 119,
      child: ListView(
        shrinkWrap: true,
        children: [
          ActionMenuWidget(
            functionPress: () {
              Navigator.of(context).pushNamed('/modifier');
            },
            text: 'Modificadores',
          ),
          ActionMenuWidget(
            functionPress: () {
              Navigator.of(context).pushNamed('/menu');
            },
            text: 'Menu',
          ),
          ActionMenuWidget(
            functionPress: () {
              Navigator.of(context).pushNamed('/items');
            },
            text: 'Articulos',
          ),
        ],
      ),
    );
  }
}
