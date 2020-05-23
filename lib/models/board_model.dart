class Board {
  final int _id;
  final String _title;

  Board({int id = 0, String title})
      : _id = id,
        _title = title;

  int get id => _id;
  String get title => _title;

  Board copyWith({
    int id,
    String title,
  }) {
    return Board(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toJson() {
    assert(id != null && title != null);

    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  static Board fromJson(Map<String, dynamic> map) => Board(
        id: int.parse(map['id'] as String),
        title: map['title'] as String,
      );
}
