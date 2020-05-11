import 'package:flt_task_board/constants.dart';
import 'package:flt_task_board/models/task_lane_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoardLaneHeader extends StatelessWidget {
  final TaskLane lane;
  final int laneItems;
  BoardLaneHeader(this.lane, this.laneItems);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 8.0),
      child: Row(
        children: [
          Text(
            lane.title,
            style: kTitleTextStyle,
          ),
          SizedBox(width: 8.0),
          Chip(
            backgroundColor: Colors.grey.shade300,
            label: Text('$laneItems'),
          ),
          Spacer(),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            buttonPadding: EdgeInsets.all(0.0),
            children: <Widget>[
              IconButton(
//                padding: EdgeInsets.all(4.0),
                icon: FaIcon(Icons.add),
                color: Colors.grey.shade500,
                onPressed: () {},
              ),
              IconButton(
                icon: FaIcon(Icons.more_horiz),
                color: Colors.grey.shade500,
                onPressed: () {},
              )
            ],
          ),
        ],
      ),
    );
  }
}
