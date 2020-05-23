import 'package:flt_task_board/constants.dart';
import 'package:flt_task_board/db/db.dart';
import 'package:flt_task_board/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final db = DB();

class BoardTask extends StatelessWidget {
  final Task task;
  BoardTask(this.task);

  static final Map<int, String> dueTitles = {
    0: 'Today',
    1: 'Tomorrow',
    -1: 'Yesterday'
  };
  static final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  static String getDueDays(DateTime date) {
    final diff = date?.difference(DateTime.now());
    if (diff == null) return 'No Due';
    if (dueTitles.containsKey(diff.inDays))
      return '${dueTitles[diff.inDays]}';
    else if (diff.inDays > 5) {
      return 'by ${months[date.month - 1]} ${date.day} ';
    } else if (diff.inDays < 0) {
      return 'by ${diff.inDays.abs()} Days';
    } else {
      return 'in ${diff.inDays} Days';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: kRoundedBorderRadius,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                  child: Text(
                    task.title,
                    style: kTitleTextStyle,
                  ),
                ),
                Text(
                  task.description ?? '',
                  maxLines: 3,
//                  overflow: TextOverflow.ellipsis,
                  style: kBodySecondaryTextStyle,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.5,
//            indent: 0.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 16.0,
              bottom: 8.0,
            ),
            child: Row(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () {},
                  icon: FaIcon(Icons.timer),
                  label: Text(getDueDays(task.dueBy)),
                  textColor: Colors.grey.shade400,
                ),
                Spacer(),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    task.user?.avatar ?? db.users[task.assignedTo - 1].avatar,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
