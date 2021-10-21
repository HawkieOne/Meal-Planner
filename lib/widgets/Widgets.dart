
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget TextCaptionLeft(dynamic context, String text, TextStyle? style) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: style,
    ),
  );
}

Widget TextCaptionCenter(dynamic context, String text, TextStyle? style) {
  return Center(
    child: Text(
      text,
      style: style,
    ),
  );
}

// ignore: non_constant_identifier_names
Widget TextInput(dynamic context, String hintText) {
  return TextField(
    decoration: InputDecoration(
      hintText: hintText,
      contentPadding: EdgeInsets.all(5.0),
      isDense: true,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
  );
}