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
}
