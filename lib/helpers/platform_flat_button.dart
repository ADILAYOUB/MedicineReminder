import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformFlatButton extends StatelessWidget {
  final VoidCallback handler;
  final Widget buttonChild;
  final Color color;

  PlatformFlatButton(
      {required this.buttonChild, required this.color, required this.handler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: color,
            onPressed: handler,
            borderRadius: BorderRadius.circular(15.0),
            child: buttonChild,
          )
        : FlatButton(
            color: color,
            onPressed: handler,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: buttonChild,
          );
  }
}
