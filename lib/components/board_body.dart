import 'package:flt_task_board/components/board_content.dart';
import 'package:flt_task_board/components/board_top_actionbar.dart';
import 'package:flt_task_board/constants.dart';
import 'package:flt_task_board/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BoardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskSearchQuery(),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kContentPaddingHorizontal,
//          vertical: 8.0,
          ),
          child: Column(
            children: <Widget>[
              BoardTopActionsBar(),
//            SizedBox(height: 4.0),
              Flexible(child: BoardContent()),
            ],
          ),
        ),
      ),
    );
  }
}
