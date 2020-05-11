class Task {
  final int _id;
  final String _title;
  final String _description;
  final String _tags;
  final DateTime _dueBy;
  final int _order;
  final int _boardId;
  final int _laneId;
  final int _assignedTo;

  Task(
      {int id = 0,
      String title,
      String description,
      String tags,
      DateTime dueBy,
      int order = 0,
      int boardId,
      int laneId,
      int assignedTo})
      : _id = id,
        _title = title,
        _description = description,
        _tags = tags,
        _dueBy = dueBy,
        _boardId = boardId,
        _order = order,
        _laneId = laneId,
        _assignedTo = assignedTo;

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get tags => _tags;
  DateTime get dueBy => _dueBy;
  int get order => _order;
  int get boardId => _boardId;
  int get laneId => _laneId;
  int get assignedTo => _assignedTo;
}
