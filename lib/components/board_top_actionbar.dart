import 'package:flt_task_board/constants.dart';
import 'package:flt_task_board/gql/gql_queries.dart';
import 'package:flt_task_board/gql/gql_query.dart';
import 'package:flt_task_board/models/app_state.dart';
import 'package:flt_task_board/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';

class BoardTopActionsBar extends StatelessWidget {
  final _debouncer = Debouncer(milliseconds: 500);
  @override
  Widget build(BuildContext context) {
    Widget searchItemsInputText = TextField(
      onChanged: (value) {
        _debouncer.run(() {
          final taskSearchQuery =
              Provider.of<TaskSearchQuery>(context, listen: false);
          if (value.length != 0 &&
              (value.length < 5 || taskSearchQuery.isQueryRunning)) return;
          taskSearchQuery.query = value;
        });
      },
      style: kTitleTextStyle.copyWith(
          fontSize: 14.0, fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          size: kButtonIconSize,
        ),
        hintText: 'Search Items',
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
        border: OutlineInputBorder(
//          gapPadding: 0.0,
          borderRadius: kRoundedBorderRadius,
//            borderSide: BorderSide.none,
        ),
      ),
    );
    Widget leftActionButtons = ButtonBar(
//      mainAxisAlignment: MainAxisAlignment.end,
      alignment: MainAxisAlignment.end,
//      buttonHeight: 60.0,
      buttonMinWidth: 100.0,
      buttonAlignedDropdown: true,
      children: <Widget>[
        FlatButton.icon(
          textColor: Colors.white,
          shape: kRoundedRectBorder,
//          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          icon: FaIcon(
            Icons.add,
            size: kButtonIconSize,
          ),
          label: Text(
            'New Item',
            style: kButtonTextStyle.copyWith(color: Colors.white),
          ),
          onPressed: () {},
          color: Theme.of(context).primaryColor,
        ),
//        SizedBox(width: 16.0),
        FlatButton.icon(
          textColor: kGreyTextColor,
          color: kGreyBackgroundColor,
          onPressed: () {},
//          borderSide: BorderSide(color: kGreyBorderColor),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: kGreyBorderColor),
            borderRadius: kRoundedBorderRadius,
          ),
//          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          icon: FaIcon(
            Icons.sort,
            size: kButtonIconSize,
          ),
          label: Text(
            'Filter',
            style: kButtonTextStyle.copyWith(
              color: kGreyTextColor,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: kGreyBackgroundColor,
            border: Border.all(color: kGreyBorderColor),
            borderRadius: kRoundedBorderRadius,
          ),
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
          child: BoardsDDLB(),
        ),
//          },
//        )
      ],
    );
    return Container(
      height: kTopButtonBarHeight,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: SizedBox(
//            width: kLaneWidth,
              height: 35.0,
              child: searchItemsInputText,
            ),
          ),
          Flexible(flex: 4, child: leftActionButtons),
        ],
      ),
    );
  }
}

class BoardsDDLB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildQuery();
  }

  Widget buildQuery() {
    return Query(
      options: QueryOptions(
        documentNode:
            gql(kGQL_AllBoards), // this is the query string you just created
      ),
      builder: (QueryResult result,
          {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final data = result.data['boards'].cast<Map<String, dynamic>>();
        final List<String> boardTitles = [];
        for (final board in data) {
          boardTitles.add(board['title']);
        }

        return buildBoardsDDLB(boardTitles);
      },
    );
  }

  Widget buildBoardsDDLB(List<String> boardTitles) {
    return DropdownButton<String>(
      value: boardTitles[0],
      iconSize: 24,
      isDense: true,
      style: kButtonTextStyle.copyWith(
        color: kGreyTextColor,
//                fontSize: 20,
      ),
      onChanged: (value) {},

//      items: <String>['Board', 'Two', 'Free', 'Four']
      items: boardTitles.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      underline: Container(),
    );
  }
}
