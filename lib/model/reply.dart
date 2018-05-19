import 'dart:convert';

import 'package:v2ex_app/model/member.dart';

class Reply {
    final int id;
    final String content;
    final int thanks;
    final int created;
    final int last_modified;
    final Member member;

    Reply(
        {this.id,
            this.content,
            this.thanks,
            this.created,
            this.last_modified,
            this.member});

    static List<Reply> fromJson(String info) {
        return json.decode(info).map<Reply>((obj) => Reply.fromMap(obj)).toList();
    }

    static Reply fromMap(Map map) {
        return new Reply(
            id: map['id'],
            content: map['content'],
            thanks: map['thanks'],
            created: map['created'],
            last_modified: map['last_modified'],
            member: Member.fromMap(map['member']));
    }
}

/*
replay
*
{
    "id": 5637703,
    "thanks": 0,
    "content": "+10086",
    "content_rendered": "+10086",
    "member": {
      "id": 83510,
      "username": "songjiaxin2008",
      "tagline": "道阻且长 行则将至",
      "avatar_mini": "//cdn.v2ex.com/avatar/29cc/fca0/83510_mini.png?m=1511405862",
      "avatar_normal": "//cdn.v2ex.com/avatar/29cc/fca0/83510_normal.png?m=1511405862",
      "avatar_large": "//cdn.v2ex.com/avatar/29cc/fca0/83510_large.png?m=1511405862"
    },
    "created": 1525663820,
    "last_modified": 1525663820
  },
* */