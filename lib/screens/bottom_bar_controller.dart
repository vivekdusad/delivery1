import 'package:delivery/components/BNavigation.dart';
import 'package:delivery/screens/home/home.dart';
import 'package:flutter/material.dart';

class BottomBarController extends StatelessWidget {
  BottomBarController({Key key}) : super(key: key);
  final pages = <Widget>[
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BNavigation(),
      body: PageView.builder(
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }
}
