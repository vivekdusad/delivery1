import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeSkeleton extends StatefulWidget {
  const HomeSkeleton({Key key}) : super(key: key);

  @override
  _HomeSkeletonState createState() => _HomeSkeletonState();
}

class _HomeSkeletonState extends State<HomeSkeleton> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final color = Colors.grey;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer(
            period: Duration(seconds: 3),
            gradient: LinearGradient(colors: [
              Colors.white,
              color,
            ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: width,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  width: width,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: 200,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 90,
                          width: 90,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 90,
                          width: 90,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 90,
                          width: 90,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: 90,
                          width: 90,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: 200,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  width: width,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
