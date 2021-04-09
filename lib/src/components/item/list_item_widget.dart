import 'package:client_delivery_app/src/components/item/item_widget.dart';
import 'package:client_delivery_app/src/components/modifier/item_modifier_widget.dart';
import 'package:client_delivery_app/src/model/item.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatefulWidget {
  final List<Item> listItem;
  ListItemWidget({Key key, @required this.listItem}) : super(key: key);

  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listItem.length,
      itemBuilder: (context, index) {
        return ItemWidget(item: widget.listItem[index]);
      },
    );
  }
}
