import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:v2ex_app/model/node.dart';
import 'package:v2ex_app/pages/topicList.dart';
import 'package:v2ex_app/utils/api.dart';

class MyGridView {
  GestureDetector getStructuredGridCell(Node node, movieTo) {
    Image img;
    if (node.avatar_normal == null) {
      img = new Image(
        image: new AssetImage('lib/icon/icon.png'),
        height: 64.0,
        width: 64.0,
      );
    } else {
      img = new Image.network(
        'https:' + node.avatar_normal,
        height: 64.0,
        width: 64.0,
      );
    }
    return new GestureDetector(
        onTap: () {
          movieTo(node.name, node.id);
        },
        child: new Card(
            elevation: 1.6,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                img,
                new Center(
                  child: new Text(node.name),
                )
              ],
            )));
  }

  GridView build(List<Node> nodes, onTap) {
    return new GridView.count(
        primary: true,
        padding: const EdgeInsets.all(1.0),
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        children: nodes.map<Widget>((Node n) {
          return getStructuredGridCell(n, onTap);
        }).toList());
  }
}

class FavNodeGridPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _FavNodeGridPage();
}

class _FavNodeGridPage extends State<FavNodeGridPage> {
  NodeProvider nodeProvider = null;
  List<Node> favNodes = [];
  final MyGridView myGridView = new MyGridView();

  loadData() async {
    nodeProvider = new NodeProvider();
    favNodes = await nodeProvider.getFavNode();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    movieTo(name, id) {
//            var url = TopicListUrl + '?node_id=' + id.toString();
//            Navigator.of(context).pop([name,url]);
      Navigator.push(context,
          new MaterialPageRoute<void>(builder: (BuildContext context) {
        var url = TopicListUrl + '?node_id=' + id.toString();
        return new TopicListPage(name: name, url: url);
      }));
    }

    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("Bookmark"),
      ),
      body: myGridView.build(favNodes, movieTo),
    );
  }
}
