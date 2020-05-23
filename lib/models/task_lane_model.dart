class TaskLane {
  final int _id;
  final String _title;
  final int _boardId;
  final int _order;

  TaskLane({int id = 0, String title, int boardId, int order})
      : _id = id,
        _title = title,
        _boardId = boardId,
        _order = order;

  int get id => _id;
  String get title => _title;
  int get boardId => _boardId;
  int get order => _order;

  TaskLane copyWith({
    int id,
    int boardId,
    int order,
    String title,
  }) {
    return TaskLane(
      id: id ?? this.id,
      boardId: boardId ?? this.boardId,
      order: order ?? this.order,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toJson() {
    assert(id != null && title != null && boardId != null && order != null);

    return <String, dynamic>{
      'id': id,
      'boardId': boardId,
      'order': order,
      'title': title,
    };
  }

  static TaskLane fromJson(Map<String, dynamic> map) => TaskLane(
        id: int.parse(map['id'] as String),
        boardId: map['boardId'] as int,
        order: map['order'] as int,
        title: map['title'] as String,
      );
}
