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