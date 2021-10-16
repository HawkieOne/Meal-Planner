import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {

  final String title;
  const CustomAppBar({Key? key, required this.title}) : preferredSize =
  const Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor),
      title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline5,
      ),
      centerTitle: true,
      actions: <Widget>[
       Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: IconButton(
          icon: Icon(
            Icons.settings,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
       )
      ],
    );
  }
}