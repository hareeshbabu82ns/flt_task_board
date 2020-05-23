import 'package:flt_task_board/components/board_layout.dart';
import 'package:flt_task_board/components/nav_bar_top.dart';
import 'package:flt_task_board/constants.dart';
import 'package:flt_task_board/gql/client_provider.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

const String host = '192.168.0.33:8000';
const String GRAPHQL_ENDPOINT = 'http://$host/graphql/';
const String SUBSCRIPTION_ENDPOINT = 'ws://$host/subscriptions';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClientProvider(
      uri: GRAPHQL_ENDPOINT,
//      subscriptionUri: SUBSCRIPTION_ENDPOINT,
      child: OKToast(
        child: MaterialApp(
          title: 'Task Board',
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
        ),
      ),
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
