import 'package:flutter/material.dart';
import 'package:v2ex_app/model/reply.dart';

class ReplyListItem extends StatelessWidget {
  final Reply r;

  ReplyListItem(this.r);

  @override
  Widget build(BuildContext context) {
    return new  Card(
          child: new Padding(
            padding: new EdgeInsets.only(left:8.0,top: 10.0,right: 8.0,bottom: 10.0),
            child: new Text(
              r.content,
              overflow: TextOverflow.fade,
              style: new TextStyle(fontWeight: FontWeight.normal,fontSize: 16.0),
            ),

          )
    );
  }
}
