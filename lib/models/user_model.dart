class User {
  final int _id;
  final String _name;
  final String _avatar;

  User({int id = 0, String name, String avatar = ''})
      : _id = id,
        _name = name,
        _avatar = avatar;

  int get id => _id;
  String get name => _name;
  String get avatar => _avatar;

  User copyWith({
    int id,
    String title,
    String avatar,
  }) {
    return User(
      id: id ?? this.id,
      name: title ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toJson() {
    assert(id != null && name != null && avatar != null);

    return <String, dynamic>{
      'id': id,
      'name': name,
      'avatar': avatar,
    };
  }

  static User fromJson(Map<String, dynamic> map) => User(
        id: int.parse(map['id'] as String),
        name: map['name'] as String,
        avatar: map['avatar'] as String,
      );
}
