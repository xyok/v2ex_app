import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myapp/item/postPage.dart';
import 'package:myapp/item/postlist.dart';
import 'package:myapp/model/post.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'test list',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new HotTops(),
    );
  }
}

class HotTops extends StatefulWidget {
  @override
  createState() => new MainState();
}

class MainState extends State<HotTops> {
  List<Post> _posts = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    String dataURL = "https://www.v2ex.com/api/topics/hot.json";
    http.Response response = await http.get(dataURL);
    setState(() {
      _posts = Post.fromJson(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('v2ex hot'),
        ),
        body: creatListView(context));
  }

  Widget _itemBuilder(BuildContext context, int index) {
    Post p = _posts[index];
    return new PostListItem(
      p,
      () {
        showPost(context, p);
      },
    );
  }

  void showPost(BuildContext context, Post p) {
    Navigator.push(context,
        new MaterialPageRoute<void>(builder: (BuildContext context) {
      return new PostPage(post: p);
    }));
  }

  Widget creatListView(BuildContext context) {
    return new RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        child: new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(1.0),
            itemCount: _posts.length,
            itemBuilder: _itemBuilder));
  }

  Future<Null> _onRefresh() {
    Completer<Null> completer = new Completer<Null>();

    loadData();
    completer.complete(null);

    return completer.future;
  }
}
