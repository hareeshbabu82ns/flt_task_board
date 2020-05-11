import 'package:flt_task_board/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoardNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kTopActionBarHeight,
      padding: EdgeInsets.symmetric(horizontal: kContentPaddingHorizontal),
      decoration: BoxDecoration(
        color: kGreyBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey,
            blurRadius: 1.0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Product Design Board',
                style: kTitleTextStyle,
              ),
              SizedBox(width: 16.0),
              Chip(
                shape: kRoundedRectBorder,
                label: Text(
                  'Sprint 8',
                  style: kTitleTextStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                      fontSize: 10.0,
                      color: Colors.white),
                ),
                backgroundColor: Theme.of(context).primaryColor,
                labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
              )
            ],
          ),
          FlatButton.icon(
            textColor: Theme.of(context).primaryColor,
            onPressed: () {},
            icon: FaIcon(Icons.add),
            label: Text(
              'New Member',
              style: kTitleTextStyle.copyWith(
                  color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
