import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:v2ex_app/model/node.dart';
import 'package:v2ex_app/pages/topicList.dart';
import 'package:v2ex_app/utils/api.dart';

class NodeChip extends StatelessWidget {
  final Node n;
  NodeProvider nodeProvider;

  NodeChip(this.n);

  Color _nameToColor(String name) {
    assert(name.length > 0);
    final int hash = name.hashCode & 0xffff;
    final double hue = 360.0 * hash / (1 << 15);
    return new HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  String _capitalize(String name) {
    assert(name != null && name.isNotEmpty);
    return name.substring(0, 1).toUpperCase() + name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    Future<Null> _addToFav() async {
      return showDialog<Null>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('加入收藏'),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new Text('将会添加到书签栏'),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  nodeProvider = new NodeProvider();
                  nodeProvider.insert(n);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    onLongPress() {
      _addToFav();
    }

    return new GestureDetector(
        onLongPress: onLongPress,
        onTap: () {
          Navigator.push(context,
              new MaterialPageRoute<void>(builder: (BuildContext context) {
            var url = TopicListUrl + '?node_id=' + n.id.toString();
            return new TopicListPage(name: n.title, url: url);
          }));
        },
        child: new Chip(
          key: new ValueKey<String>(n.name),
          backgroundColor: _nameToColor(n.name),
          label:
              new Text(_capitalize(n.title) + ' (' + n.topics.toString() + ')'),
        ));
  }
}
