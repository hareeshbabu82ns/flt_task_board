import 'package:flt_task_board/components/board_layout.dart';
import 'package:flt_task_board/components/nav_bar_top.dart';
import 'package:flt_task_board/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF074cff),
        scaffoldBackgroundColor: kGreyBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: IconThemeData(size: 24.0, color: Colors.black87),
        textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: 16.0, color: Colors.black87),
        ),
      ),
      home: MyHomePage(title: 'Task Board'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        title: TopNavBar(),
      ),
      body: BoardLayout(),
    );
  }
}
