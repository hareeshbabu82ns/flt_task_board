import 'package:flt_task_board/boardview/board_item.dart';
import 'package:flt_task_board/boardview/board_list.dart';
import 'package:flt_task_board/boardview/board_view.dart';
import 'package:flt_task_board/components/board_lane_header.dart';
import 'package:flt_task_board/components/board_task.dart';
import 'package:flt_task_board/constants.dart';
import 'package:flt_task_board/db/db.dart';
import 'package:flutter/material.dart';

final db = DB();

class BoardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final boardLists = db.lanes.map((lane) {
      final items = db.tasks
          .where((task) => task.laneId == lane.id)
          .map((task) => BoardItem(
                index: task.order,
                item: BoardTask(task),
                draggable: true,
                onDropItem: (int i, int j, int k, int l, BoardItemState state) {
                  print(
                      'onDropItem from(lane:$k, item:$l) to(lane:$i, item:$j) ');
                },
                onStartDragItem: (int i, int j, BoardItemState state) {
                  print('onStartDragItem $i, $j');
                },
              ))
          .toList();

      return BoardList(
        backgroundColor: kGreyBackgroundColor,
        header: BoardLaneHeader(lane, items.length),
        index: lane.order,
        items: items,
        draggable: true,
        onDropList: (int i, int j) {
          print('onDropList from lane:$j to lane:$i, ');
        },
        onStartDragList: (int i) {
          print('inStartDragList lane:$i');
        },
      );
    }).toList();

    return BoardView(
      width: kLaneWidth,
      bottomPadding: 8.0,
      lists: boardLists,
    );
  }
}

//
//class BoardContent extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      color: Colors.blueGrey,
//      child: BoardLane(db.lanes[0]),
//    );
//  }
//}
//
//class BoardLane extends StatelessWidget {
//  final TaskLane taskLane;
//  BoardLane(this.taskLane);
//  @override
//  Widget build(BuildContext context) {
//    final taskItems = db.tasks
//        .where((task) =>
//            task.boardId == taskLane.boardId && task.laneId == taskLane.id)
//        .toList();
//    return Container(
//      color: kGreyBackgroundColor,
//      width: kLaneWidth,
//      child: Column(
//        children: <Widget>[
//          BoardLaneHeader(taskLane, taskItems.length),
//          Flexible(
//            child: DragTarget(
//              builder: (_, __, ___) {
//                return ListView.builder(
//                    itemCount: taskItems.length,
//                    itemBuilder: (_, index) {
//                      return Draggable(
//                          data: taskItems[index],
//                          childWhenDragging: Container(
//                            width: 100,
//                            height: 100,
//                            color: Colors.red,
//                          ),
//                          feedback: BoardTask(taskItems[index]),
//                          child: BoardTask(taskItems[index]));
//                    });
//              },
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
