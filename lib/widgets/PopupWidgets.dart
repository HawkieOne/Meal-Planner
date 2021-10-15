
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget TextCaption(dynamic context, String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.bodyText2,
    ),
  );
}

// ignore: non_constant_identifier_names
Widget TextInput(dynamic context) {
  return TextField(
    onChanged: (value) {

    },
  );
}