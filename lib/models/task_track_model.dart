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
}
