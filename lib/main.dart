import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/components/home_skeleton.dart';
import 'package:delivery/model/banners.dart';
import 'package:delivery/model/data_provider.dart';
import 'package:delivery/screens/home/home.dart';
import 'package:delivery/screens/login.dart';
import 'package:delivery/screens/select_region.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splash());
  }
}

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

List<BannersObject> banners;

class _SplashState extends State<Splash> {
  var pincode;
  Future _getData() async {
    await UserData.getUser();
    pincode = await UserData.getRegion();
    user = await FirebaseAuth.instance.currentUser();
    QuerySnapshot snapshot = await DataProvider().banners("slide");
    List<BannersObject> list =
        snapshot.documents.map((e) => BannersObject.fromMap(e.data)).toList();
    banners = list;
    list.map((e) {
      precacheImage(CachedNetworkImageProvider(e.image), context);
    });    
  }

  FirebaseUser user;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return FutureBuilder<DocumentSnapshot>(
                    future: Firestore.instance
                        .collection("Users")
                        .document(snapshot.data.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data.data;
                        if (data['pincode'] != null) {
                          return HomeScreen();
                        } else {
                          return SelectRegion();
                        }
                      }
                      return HomeSkeleton();
                    },
                  );
              }
              return Login();
            }
            return Login();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
