import 'package:flt_task_board/boardview/board_item.dart';
import 'package:flt_task_board/boardview/board_list.dart';
import 'package:flt_task_board/boardview/board_view.dart';
import 'package:flt_task_board/components/board_lane_header.dart';
import 'package:flt_task_board/components/board_task.dart';
import 'package:flt_task_board/components/task_edit.dart';
import 'package:flt_task_board/constants.dart';
import 'package:flt_task_board/gql/gql_provider.dart';
import 'package:flt_task_board/gql/gql_queries.dart';
import 'package:flt_task_board/gql/gql_query.dart';
import 'package:flt_task_board/models/app_state.dart';
import 'package:flt_task_board/models/board_model.dart';
import 'package:flt_task_board/models/task_lane_model.dart';
import 'package:flt_task_board/models/task_model.dart';
import 'package:flt_task_board/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class BoardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskSearchQuery>(
      builder: (context, taskQuery, child) =>
          buildFromApiWithSearch(context, searchText: taskQuery.query),
    );
  }

  Widget buildFromApiWithSearch(BuildContext context,
      {String searchText = ''}) {
    final taskSearchQuery =
        Provider.of<TaskSearchQuery>(context, listen: false);
    taskSearchQuery.isQueryRunning = true;
    return Query(
      options: QueryOptions(
        documentNode: gql(
            searchText.length > 0 ? kGQL_SearchTasks : kGQL_BoardFullDetails),
        variables: {'boardId': '1', 'searchQuery': searchText},
        // pollInterval: 30,
      ),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          taskSearchQuery.isQueryRunning = false;
          return Text(result.exception.toString());
        }

        if (result.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        taskSearchQuery.isQueryRunning = false;

        final List data = result.data['boards'];
        for (final LazyCacheMap boardCache in data) {
          if (boardCache['id'] != '1') continue; // not current selected model
          final board = boardCache.data;
          final boardModel = Board.fromJson(board);
          final List<BoardList> boardLanes = [];
          for (final lane in board['lanes']) {
            final laneModel =
                TaskLane.fromJson(lane).copyWith(boardId: boardModel.id);
            final List<BoardItem> taskItems = [];
            for (final task in lane['tasks']) {
              final taskModel = Task.fromJson(task)
                  .copyWith(boardId: boardModel.id, laneId: laneModel.id);
              taskItems.add(BoardItem(
                id: taskModel.id,
                index: taskModel.order,
                item: BoardTask(taskModel),
                // item: BoardTask(taskModel),
                draggable: true,
                onDropItem: (
                    {int listId,
                    int itemId,
                    int listIndex,
                    int itemIndex,
                    int oldListIndex,
                    int oldItemIndex,
                    BoardItemState state}) async {
                  print(
                      'onDropItem $itemId:  from(lane:$oldListIndex, item:$oldItemIndex) to(lane:$listId, item:$itemIndex) ');
                  if (listIndex == oldListIndex && itemIndex == oldItemIndex)
                    return;
                  final MutationOptions options = MutationOptions(
                    documentNode: gql(kGQL_MoveTask),
                    variables: {
                      'taskId': itemId,
                      'toLane': listId,
                      'toItemOrder': itemIndex + 1,
                    },
                  );
                  final QueryResult result =
                      await GraphQLProvider.of(context).value.mutate(options);

                  if (result.hasException) {
                    showToast("Task could not be moved, Please Retry");
                    refetch();
                    return;
                  }
                },
                onTapItem: ({itemId, itemIndex, listId, listIndex, state}) =>
                    showTaskEditDialog(context, taskModel, refetch),
                onStartDragItem: (
                    {int listId,
                    int itemId,
                    int listIndex,
                    int itemIndex,
                    BoardItemState state}) {
                  print('onStartDragItem $listId, $itemIndex');
                },
              ));
            }
            boardLanes.add(BoardList(
              backgroundColor: kGreyBackgroundColor,
              header: (context, state) =>
                  BoardLaneHeader(laneModel, state.widget.items.length, (lane) {
                //add task
                final task =
                    Task(boardId: laneModel.boardId, laneId: laneModel.id);
                showTaskEditDialog(context, task, refetch);
              }),
              id: laneModel.id,
              index: laneModel.order,
              items: taskItems,
              draggable: true,
              onDropList: (
                  {int listId, int listIndex, int oldListIndex}) async {
                print('onDropList from lane:$oldListIndex to lane:$listId ');
                if (listIndex == oldListIndex) return;
                final MutationOptions options = MutationOptions(
                  documentNode: gql(kGQL_MoveLane),
                  variables: {
                    'laneId': listId,
                    'toLaneOrder': listIndex + 1,
                  },
                );
                final QueryResult result =
                    await GraphQLProvider.of(context).value.mutate(options);

                if (result.hasException) {
                  showToast("Lane could not be moved, Please Retry");
                  refetch();
                  return;
                }
              },
              onStartDragList: ({int listId, int listIndex}) {
                print('inStartDragList lane:$listId');
              },
            ));
          }
          return BoardView(
            width: kLaneWidth,
            bottomPadding: 8.0,
            lists: boardLanes,
          );
        }

        return Container(
          child: Center(
            child: Text('Error Loading Content...'),
          ),
        );
      },
    );
  }

  void showTaskEditDialog(
      BuildContext context, Task task, Function boardRefetch) {
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Query(
          options: QueryOptions(
            documentNode: gql(kGQL_TaskEditListValues),
            variables: {'boardId': task.boardId},
          ),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.hasException) {
              return Text('Error preparing Task form');
            }

            if (result.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final users = result.data['users'] as List;
            final lanes = result.data['lanes'] as List;

            return TaskEditForm(
              task: task,
              users: users.map((user) => User.fromJson(user)).toList(),
              lanes: lanes.map((lane) => TaskLane.fromJson(lane)).toList(),
              onCreate: (Task task) async {
                print('creating task: ${task.toJson()}');
                final jsonTask = task.toJson();
                jsonTask.remove('id');
                final MutationOptions options = MutationOptions(
                  documentNode: gql(kGQL_CreateTask),
                  variables: {
                    'taskInput': jsonTask,
                  },
                );
                final QueryResult result =
                    await GraphQLProvider.of(context).value.mutate(options);

                if (result.hasException) {
                  showToast("Task could not be created, Please Retry");
                  return;
                }

                showToast("Task created");
                boardRefetch();
                Navigator.pop(context);
              },
              onUpdate: (Task task) async {
                final jsonTask = task.toJson();
                jsonTask.remove('id');
                print('updating task: ${task.toJson()}');
                final MutationOptions options = MutationOptions(
                  documentNode: gql(kGQL_UpdateTask),
                  variables: {
                    'taskId': task.id,
                    'taskInput': jsonTask,
                  },
                );

                final QueryResult result =
                    await GraphQLProvider.of(context).value.mutate(options);

                if (result.hasException) {
                  showToast("Task could not be updated, Please Retry");
                  return;
                }

                showToast("Task updated");
                boardRefetch();
                Navigator.pop(context);
              },
              onDelete: (Task task) async {
                final MutationOptions options = MutationOptions(
                  documentNode: gql(kGQL_DeleteTask),
                  variables: {
                    'taskId': task.id,
                  },
                );
                final QueryResult result =
                    await GraphQLProvider.of(context).value.mutate(options);

                if (result.hasException) {
                  showToast("Task could not be deleted, Please Retry");
                  return;
                }

                showToast("Task deleted");
                boardRefetch();
                Navigator.pop(context);
              },
            );
          }),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }
}
