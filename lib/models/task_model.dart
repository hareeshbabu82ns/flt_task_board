import 'package:flt_task_board/models/user_model.dart';

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
  final User _user;

  Task({
    int id = 0,
    String title,
    String description,
    String tags,
    DateTime dueBy,
    int order = 0,
    int boardId,
    int laneId,
    int assignedTo,
    User user,
  })  : _id = id,
        _title = title,
        _description = description,
        _tags = tags,
        _dueBy = dueBy,
        _boardId = boardId,
        _order = order,
        _laneId = laneId,
        _assignedTo = assignedTo,
        _user = user;

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get tags => _tags;
  DateTime get dueBy => _dueBy;
  int get order => _order;
  int get boardId => _boardId;
  int get laneId => _laneId;
  int get assignedTo => _assignedTo ?? _user?.id ?? 0;
  User get user => _user;

  Task copyWith({
    int id,
    String title,
    String description,
    String tags,
    DateTime dueBy,
    int order,
    int boardId,
    int laneId,
    int assignedTo,
    User user,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      dueBy: dueBy ?? this.dueBy,
      order: order ?? this.order,
      boardId: boardId ?? this.boardId,
      laneId: laneId ?? this.laneId,
      assignedTo: assignedTo ?? this.assignedTo,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toJson() {
    assert(id != null && title != null);

    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'tags': tags,
      'dueBy': (dueBy == null)
          ? DateTime.now().toUtc().toIso8601String()
          : dueBy.toUtc().toIso8601String(), //TODO: parse to valid JSON string
      'order': order,
      'boardId': boardId,
      'laneId': laneId,
      'assignedTo': assignedTo,
    };
  }

  static Task fromJson(Map<String, dynamic> map) {
    int assignedTo;
    User user;
    try {
      assignedTo = int.parse(map['assignedTo'] as String ?? '0');
    } catch (e) {
      assignedTo = null;
    }
    if (assignedTo == null) {
      try {
        user = User.fromJson(map['assignedTo']);
      } catch (e) {
        user = null;
      }
    }
    return Task(
      id: int.parse(map['id'] as String),
      title: map['title'] as String,
      description: map['description'] as String,
      tags: map['tags'] as String,
      dueBy: DateTime.parse(map['dueBy'] as String),
      order: map['order'] as int,
      boardId: int.parse(map['boardId'] as String ?? '0'),
      laneId: map['laneId'] ?? int.parse(map['laneId'] as String ?? '0'),
      assignedTo: assignedTo,
      user: user,
    );
  }
}
