import 'package:flt_task_board/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoardTopActionsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget searchItemsInputText = TextField(
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
//        SizedBox(width: 16.0),
        Container(
          decoration: BoxDecoration(
            color: kGreyBackgroundColor,
            border: Border.all(color: kGreyBorderColor),
            borderRadius: kRoundedBorderRadius,
          ),
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
          child: DropdownButton<String>(
            value: 'Board',
            iconSize: 24,
            isDense: true,
            style: kButtonTextStyle.copyWith(
              color: kGreyTextColor,
//                fontSize: 20,
            ),
            onChanged: (value) {},
            items: <String>['Board', 'Two', 'Free', 'Four']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            underline: Container(),
          ),
        )
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
