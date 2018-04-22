import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/model/post.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key key, this.post}) : super(key: key);

  final Post post;

  @override
  _PostPageState createState() => new _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextStyle textStyle = new TextStyle(fontSize: 16.0);

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
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('详情'),
        ),
        body: new SingleChildScrollView(
            padding: const EdgeInsets.all(2.0),
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
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ),
                        new Container(
                            padding: const EdgeInsets.all(8.0), child: author),
                        new Container(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            widget.post.content,
                            style: textStyle,
                          ),
                        ),
                      ],
                    )))));
  }
}
