import 'package:flutter/material.dart';
import 'package:myapp/model/post.dart';

class PostListItem extends StatelessWidget {
  final Post p;
  final VoidCallback onTap;

  PostListItem(this.p,this.onTap);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onTap,
      child: new Card(
          child: new Padding(
            padding: new EdgeInsets.all(12.0),
            child: new Text(
              p.title,
              overflow: TextOverflow.fade,
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),

          ))
    );
  }
}
