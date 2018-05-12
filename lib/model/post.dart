import 'dart:convert';

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

class Member {
  final int id;
  final String username;
  final String avatar_mini;
  final String avatar_normal;

  Member({this.id, this.username, this.avatar_mini, this.avatar_normal});

  static Member fromMap(Map map) {
    return new Member(
        id: map['id'],
        username: map['username'],
        avatar_mini: map['avatar_mini'],
        avatar_normal: map['avatar_normal']);
  }
}

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
}

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
