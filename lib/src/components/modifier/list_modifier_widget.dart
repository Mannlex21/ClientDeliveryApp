import 'package:client_delivery_app/src/model/modifier.dart';
import 'package:flutter/material.dart';

class ListModifierWidget extends StatefulWidget {
  final List<Modifier> listModifier;
  ListModifierWidget({Key key, @required this.listModifier}) : super(key: key);

  @override
  _ListModifierWidgetState createState() => _ListModifierWidgetState();
}

class _ListModifierWidgetState extends State<ListModifierWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listModifier.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${widget.listModifier[index].title} ${widget.listModifier[index].list[0].price}'),
        );
      },
    );
  }
}
