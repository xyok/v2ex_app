import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:v2ex_app/model/node.dart';
import 'package:v2ex_app/utils/api.dart';
import 'package:http/http.dart' as http;

class _ChipsTile extends StatelessWidget {
  const _ChipsTile({
    Key key,
    this.label,
    this.children,
  }) : super(key: key);

  final String label;
  final List<Widget> children;

  // Wraps a list of chips into a ListTile for display as a section in the demo.
  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: children.isEmpty
            ? new Center(
                child: new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    'loading',
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                ),
              )
            : new Wrap(
//                alignment: WrapAlignment.center,
                children: children
                    .map((Widget chip) => new Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: chip,
                        ))
                    .toList(),
              ),
      ),
    );
  }
}

class AllNode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NodeChipList();
}

class _NodeChipList extends State<AllNode> {


  List<Node> _nodes = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  final Set<String> _materials = new Set<String>();

  loadData() async {
    String dataURL = AllNodeUrl;
    http.Response response = await http.get(dataURL);
    setState(() {
      _nodes = Node.fromJson(response.body);
    });
  }

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
    final List<Widget> chips = _nodes.map<Widget>((Node n) {
      return new Chip(
        key: new ValueKey<String>(n.name),
        backgroundColor: _nameToColor(n.name),
        label: new Text(_capitalize(n.name)+' ('+n.topics.toString()+')'),
      );
    }).toList();

    final List<Widget> tiles = <Widget>[
      const SizedBox(height: 8.0, width: 0.0),
      new _ChipsTile(label: 'All', children: chips),
      const Divider(),
    ];

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Topics"),
      ),
      body: new ListView(
        children: tiles,
      ),
//        new SliverToBoxAdapter(child: new Chip(label: new Text('hello world'))),
    );
  }
}