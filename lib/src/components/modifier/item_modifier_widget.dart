import 'package:client_delivery_app/src/model/modifier.dart';
import 'package:flutter/material.dart';

class ItemModifierWidget extends StatefulWidget {
  final Modifier modifier;
  ItemModifierWidget({Key key, this.modifier}) : super(key: key);

  @override
  _ItemModifierWidgetState createState() => _ItemModifierWidgetState();
}

class _ItemModifierWidgetState extends State<ItemModifierWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed('/form_modifier', arguments: widget.modifier);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${widget.modifier.title}'),
            ],
          ),
        ),
      ),
    );
  }
}
