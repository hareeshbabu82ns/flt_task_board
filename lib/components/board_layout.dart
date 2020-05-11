import 'package:flt_task_board/components/board_body.dart';
import 'package:flt_task_board/components/nav_bar_board.dart';
import 'package:flutter/material.dart';

class BoardLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BoardNavBar(),
        BoardBody(),
      ],
    );
  }
}
