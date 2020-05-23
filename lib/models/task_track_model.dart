class TaskTrack {
  final int _id;
  final int _taskId;
  final int _actionBy;

  TaskTrack({int id = 0, int taskId, int actionBy})
      : _id = id,
        _taskId = taskId,
        _actionBy = actionBy;

  int get id => _id;
  int get taskId => _taskId;
  int get actionBy => _actionBy;

  TaskTrack copyWith({
    int id,
    int taskId,
    int actionBy,
  }) {
    return TaskTrack(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      actionBy: actionBy ?? this.actionBy,
    );
  }

  Map<String, dynamic> toJson() {
    assert(id != null && taskId != null && actionBy != null);

    return <String, dynamic>{
      'id': id,
      'taskId': taskId,
      'actionBy': actionBy,
    };
  }

  static TaskTrack fromJson(Map<String, dynamic> map) => TaskTrack(
        id: int.parse(map['id'] as String),
        taskId: map['taskId'] as int,
        actionBy: map['actionBy'] as int,
      );
}
