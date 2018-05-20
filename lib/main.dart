import 'package:flutter/material.dart';

import 'package:v2ex_app/pages/allNode.dart';
import 'package:v2ex_app/pages/favNodes.dart';
import 'package:v2ex_app/pages/topicList.dart';
import 'package:v2ex_app/utils/api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new TopicListPage(),
      routes: <String, WidgetBuilder>{
        '/topicList': (BuildContext context) => new TopicListPage(),
        '/FavTopics': (BuildContext context) => new FavNodeGridPage(),
        '/topics': (BuildContext context) => new AllNode(),
      },
    );
  }
}
