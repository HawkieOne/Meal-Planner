import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget dateInfo(dynamic context, String dayTitle, VoidCallback prevFunction, VoidCallback nextFunction) {
  return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Material(
            borderRadius: BorderRadius.circular(25),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              highlightColor: Colors.grey,
              splashRadius: 24,
              onPressed: prevFunction,
            ),
          ),
          Text(
            dayTitle,
            style: Theme.of(context).textTheme.headline3,
          ),
          Material(
            borderRadius: BorderRadius.circular(25),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward),
              highlightColor: Colors.grey,
              splashRadius: 24,
              onPressed: nextFunction,
            ),
          ),
        ],
      )
  );
}