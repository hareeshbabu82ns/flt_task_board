class Board {
  final int _id;
  final String _title;

  Board({int id = 0, String title})
      : _id = id,
        _title = title;

  int get id => _id;
  String get title => _title;
}
