import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:v2ex_app/item/postPage.dart';
import 'package:v2ex_app/item/postlist.dart';
import 'package:v2ex_app/model/post.dart';
import 'package:v2ex_app/utils/api.dart';
import 'package:http/http.dart' as http;

class TopicListPage extends StatefulWidget {
  const TopicListPage({Key key, this.name, this.url}) : super(key: key);

  final String name;
  final String url;

  @override
  createState() => new MainState();
}

class MainState extends State<TopicListPage> {
  List<Post> _posts = [];
  String title = '';
  String dataURL = HotTopicsUrl;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    title = widget.name == null ? 'v2ex hot' : widget.name;
    if (widget.url != null) {
      dataURL = widget.url;
    }
    loadData(dataURL);
  }

  loadData(url) async {
    http.Response response = await http.get(url);
    setState(() {
      _posts = Post.fromJson(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
          actions: <Widget>[
            new IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {
                  Navigator.of(context).pushNamed('/FavTopics');
                }),
            new IconButton(
                icon: const Icon(Icons.apps),
                onPressed: () {
                  Navigator.of(context).pushNamed('/topics');
                }),
          ],
        ),
        body: creatListView(context));
  }

  Widget _itemBuilder(BuildContext context, int index) {
    Post p = _posts[index];
    return new PostListItem(
      p,
      () {
        Navigator.push(context,
            new MaterialPageRoute<void>(builder: (BuildContext context) {
          return new PostPage(post: p);
        }));
      },
    );
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

    loadData(dataURL);
    completer.complete(null);

    return completer.future;
  }
}
