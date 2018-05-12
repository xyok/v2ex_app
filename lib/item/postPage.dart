import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:v2ex_app/item/replylist.dart';
import 'package:v2ex_app/model/post.dart';
import 'package:http/http.dart' as http;

class PostPage extends StatefulWidget {
  const PostPage({Key key, this.post}) : super(key: key);

  final Post post;

  @override
  _PostPageState createState() => new _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Reply> _replies = [];
  final TextStyle textStyle = new TextStyle(fontSize: 16.0);

  loadData(topic_id) async {
    String dataURL =
        "https://www.v2ex.com/api/replies/show.json?topic_id=$topic_id";
    http.Response response = await http.get(dataURL);
    setState(() {
      _replies = Reply.fromJson(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    loadData(widget.post.id);
  }

  @override
  Widget build(BuildContext context) {
    final Widget author = Row(
      children: <Widget>[
        new Flexible(
            child: new Image.network(
          'http:' + widget.post.member.avatar_normal,
          width: 36.0,
          height: 36.0,
        )),
        new Flexible(
            child: Container(
                padding: const EdgeInsets.only(left: 10.0),
                child: new Text(
                  widget.post.member.username,
                  style: textStyle,
                )))
      ],
    );

    Widget body() {
      return new CustomScrollView(
        slivers: <Widget>[
          new SliverToBoxAdapter(
              child: new Card(
                  child: new Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Container(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                widget.post.title,
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                            new Container(
                                padding: const EdgeInsets.all(8.0),
                                child: author),
                            new Container(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                widget.post.content,
                                style: textStyle,
                              ),
                            ),
                          ])))),
          new SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.all(1.0),
            sliver: new SliverList(
//              gridDelegate: SliverGridDelegate,
              delegate: new SliverChildListDelegate(
                _replies.map((Reply r) {
                  return new ReplyListItem(r);
                }).toList(),
              ),
            ),
          ),
        ],
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('详情'),
      ),
      body: body(),
    );
  }
}
