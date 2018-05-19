import 'dart:convert';

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
  final int id;
  final String name;
  final String url;
  final String avatar_normal;
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
      this.topics});

  static Node fromMap(Map map) {
    return new Node(
        id: map['id'],
        name: map['name'],
        url: map['url'],
        avatar_normal: map['avatar_normal'],
        created: map['created'],
        topics: map['topics']);
  }

  static List<Node> fromJson(String info) {
    return json.decode(info).map<Node>((obj) => Node.fromMap(obj)).toList();
  }
}
