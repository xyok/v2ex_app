import 'dart:convert';

import 'package:v2ex_app/model/member.dart';

/*
"id": 439955,
    "title": "考车牌，科目一用一个星期用功，能考过吗？",
    "url": "http://www.v2ex.com/t/439955",
    "content": "你们用了多长时间？",
    "content_rendered": "<p>你们用了多长时间？</p>\n",
    "replies": 114,
    "member": {
      "id": 193122,
      "username": "xiaochengxu",
      "tagline": "",
      "avatar_mini": "//cdn.v2ex.com/gravatar/3b28e06d7df8751fbeded72ecb065343?s=24&d=retro",
      "avatar_normal": "//cdn.v2ex.com/gravatar/3b28e06d7df8751fbeded72ecb065343?s=48&d=retro",
      "avatar_large": "//cdn.v2ex.com/gravatar/3b28e06d7df8751fbeded72ecb065343?s=73&d=retro"
    },
    "node": {
      "id": 12,
      "name": "qna",
      "title": "问与答",
      "title_alternative": "Questions and Answers",
      "url": "http://www.v2ex.com/go/qna",
      "topics": 104969,
      "avatar_mini": "//cdn.v2ex.com/navatar/c20a/d4d7/12_mini.png?m=1521602077",
      "avatar_normal": "//cdn.v2ex.com/navatar/c20a/d4d7/12_normal.png?m=1521602077",
      "avatar_large": "//cdn.v2ex.com/navatar/c20a/d4d7/12_large.png?m=1521602077"
    },
    "created": 1521597427,
    "last_modified": 1521597427,
    "last_touched": 1521618980
* */



class Post {
  final int id;
  final String title;
  final String url;
  final String content;
  final int replies;
  final int created;
  final int last_modified;
  final int last_touched;
  final Member member;

  Post(
      {this.id,
      this.title,
      this.url,
      this.content,
      this.replies,
      this.created,
      this.last_modified,
      this.last_touched,
      this.member});

  static List<Post> fromJson(String info) {
    return json.decode(info).map<Post>((obj) => Post.fromMap(obj)).toList();
  }

  static Post fromMap(Map map) {
    return new Post(
        id: map['id'],
        title: map['title'],
        url: map['url'],
        content: map['content'],
        replies: map['replies'],
        created: map['created'],
        last_modified: map['last_modified'],
        last_touched: map['last_touched'],
        member: Member.fromMap(map['member']));
  }

  DateTime getCreated() {
    return DateTime.fromMillisecondsSinceEpoch(this.created *1000);
  }
}
