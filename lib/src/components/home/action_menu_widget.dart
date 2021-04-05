import 'package:flutter/material.dart';

class ActionMenuWidget extends StatefulWidget {
  final Function functionPress;
  final String text;
  ActionMenuWidget({Key key, this.functionPress, this.text}) : super(key: key);

  @override
  _ActionMenuWidgetState createState() => _ActionMenuWidgetState();
}

class _ActionMenuWidgetState extends State<ActionMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.text),
          ],
        ),
        onPressed: widget.functionPress,
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 15)),
        ),
      ),
    );
  }
}
