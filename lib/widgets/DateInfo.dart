import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget dateInfo(dynamic context, String dayTitle) {
  return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.arrow_back_ios,

          ),
          Text(
            // today.toString(),
            dayTitle,
            style: Theme.of(context).textTheme.headline3,
          ),
          Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      )
  );
}