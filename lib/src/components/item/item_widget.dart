import 'package:client_delivery_app/src/model/item.dart';
import 'package:client_delivery_app/src/model/modifier.dart';
import 'package:flutter/material.dart';

enum Commands { assign, edit }

class ItemWidget extends StatefulWidget {
  final Item item;
  ItemWidget({Key key, this.item}) : super(key: key);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text('${widget.item.name}'),
            ),
            PopupMenuButton<Commands>(
              onSelected: (Commands result) {
                switch (result) {
                  case Commands.assign:
                    break;
                  case Commands.edit:
                    Navigator.of(context).pushNamed('/form_modifier', arguments: widget.item);
                    break;
                }
              },
              itemBuilder: (BuildContext context) => [
                // CheckedPopupMenuItem<Commands>(
                //   value: Commands.assign,
                //   child: const Text('Hero and scholar'),
                // ),
                const PopupMenuItem<Commands>(
                  value: Commands.assign,
                  child: ListTile(title: Text('Asignar')),
                ),
                const PopupMenuItem<Commands>(
                  value: Commands.edit,
                  child: ListTile(title: Text('Editar')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
