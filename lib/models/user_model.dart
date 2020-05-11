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
}
