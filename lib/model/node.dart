import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

/** node info
    {
    "id": 90,
    "name": "python",
    "url": "http://www.v2ex.com/go/python",
    "title": "Python",
    "title_alternative": "Python",
    "topics": 9199,
    "stars": 6334,
    "header": "这里讨论各种 Python 语言编程话题，也包括 Django，Tornado 等框架的讨论。这里是一个能够帮助你解决实际问题的地方。",
    "footer": null,
    "created": 1278683336,
    "avatar_mini": "//cdn.v2ex.com/navatar/8613/985e/90_mini.png?m=1526367426",
    "avatar_normal": "//cdn.v2ex.com/navatar/8613/985e/90_normal.png?m=1526367426",
    "avatar_large": "//cdn.v2ex.com/navatar/8613/985e/90_large.png?m=1526367426"
    }
 * **/

class Node {
  int id;
  final String name;
  final String url;
  String avatar_normal;
  int created;
  String title;
  String header;
  int topics;
  int stars;
  String avatar_mini;

  Node(
      {this.id,
      this.name,
      this.url,
      this.avatar_normal,
      this.created,
      this.topics,
      this.title});

  static Node fromMap(Map map) {
    return new Node(
        id: map['id'],
        name: map['name'],
        url: map['url'],
        avatar_normal: map['avatar_normal'],
        created: map['created'],
        topics: map['topics'],
        title: map['title']
    );
  }

  static List<Node> fromJson(String info) {
    return json.decode(info).map<Node>((obj) => Node.fromMap(obj)).toList();
  }

  Map<String,dynamic> toMap() {
    Map<String,dynamic> map = {
      'id': id,
      'name': name,
      'url': url,
      'avatar_normal': avatar_normal,
    };
    return map;
  }
}

class NodeProvider {
  Database db;

  final String columnId = 'id';
  final String columnName = 'name';
  final String columnUrl = 'url';
  final String columnAvatar_normal = 'avatar_normal';
  final String tableName = 'fav_node';

  static final NodeProvider _singleton = new NodeProvider._internal();

  NodeProvider._internal() {}

  factory NodeProvider() {
    return _singleton;
  }

  Future initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "v2ex.db");
//    print(path);
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
                    create table $tableName (
                      $columnId integer primary key,
                      $columnName text not null,
                      $columnUrl text null,
                      $columnAvatar_normal text null);
                    ''');
    });
  }

  Future<Node> insert(Node n) async {
    if (db == null) {
      await initDB();
    }
    await db.insert(tableName, n.toMap());
    return n;
  }

  Future<List<Node>> getFavNode() async {
    if (db == null) {
      await initDB();
    }
    List<Map> maps = await db.query(tableName,
        columns: [columnId, columnName, columnUrl, columnAvatar_normal]);

    return maps.map<Node>((Map n) {
      return Node.fromMap(n);
    }).toList();
  }

  Future<int> delete(int id) async {
    return await db.delete(tableName, where: "$columnId = ?", whereArgs: [id]);
  }

  Future close() async => db.close();
}
