import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyGridView {
  GestureDetector getStructuredGridCell(name, image) {
    return new GestureDetector(
        onTap: (){
        
        },
        child: new Card(
            elevation: 1.6,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                new Image.network(
                  'https:' +
                      '//cdn.v2ex.com/navatar/8613/985e/90_normal.png?m=1526367426',
                  height: 64.0,
                  width: 64.0,
                ),
                new Center(
                  child: new Text(name),
                )
              ],
            )));
  }

  GridView build() {
    List<String> favNode = ['python','html','facebook','book','apple','world'];
    
    return new GridView.count(
      primary: true,
      padding: const EdgeInsets.all(1.0),
      crossAxisCount: 2,
      childAspectRatio: 1.0,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: favNode.map<Widget>(
              (String s){return getStructuredGridCell(s, '');}
              ).toList()
    );
  }
}

class TopciGridPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _TopicGridPage();
}

class _TopicGridPage extends State<TopciGridPage> {
  final MyGridView myGridView = new MyGridView();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("Bookmark"),
      ),
      body: myGridView.build(),
    );
  }
}
