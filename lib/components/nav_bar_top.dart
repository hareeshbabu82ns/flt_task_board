import 'package:flt_task_board/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        NavBarItem(title: 'Backlog', icon: FontAwesomeIcons.box),
        NavBarItem(title: 'Board', icon: Icons.dashboard, isActive: true),
        NavBarItem(title: 'Feed', icon: Icons.featured_play_list),
        NavBarItem(title: 'Reports', icon: Icons.insert_chart),
      ],
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;
  NavBarItem(
      {@required this.title, this.isActive = false, @required this.icon});
  @override
  Widget build(BuildContext context) {
    final color = isActive ? Colors.white : Colors.white54;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
      child: Row(
        children: <Widget>[
          FaIcon(
            icon,
            color: color,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: kTitleTextStyle.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
