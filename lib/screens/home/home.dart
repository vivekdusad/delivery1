import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/components/BNavigation.dart';
import 'package:delivery/components/home_skeleton.dart';
import 'package:delivery/model/data_provider.dart';
import 'package:delivery/screens/Search.dart';
import 'package:delivery/screens/home/widgets/banner.dart';
import 'package:delivery/screens/home/widgets/categories.dart';
import 'package:delivery/screens/home/widgets/drawer.dart';
import 'package:delivery/screens/home/widgets/grocery.dart';
import 'package:delivery/screens/home/widgets/medical.dart';
import 'package:delivery/screens/home/widgets/restaurent.dart';
import 'package:delivery/screens/select_region.dart';
import 'package:delivery/utils/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _myPage;
  double radius;
  var selectedPage;
  int index = 0;

  List<Categories> category = [
    Categories("Grocery", "assets/groceries.png"),
    Categories("Food", "assets/food.png"),
    Categories("Veg and Fruits", "assets/vega.png"),
    Categories("Medicines", "assets/med.png")
  ];

  String url = "";
  List<DealItemsData> products = [];
  List<dynamic> db = [];
  int optionss = 0;
  bool fullpage = false;

  @override
  void initState() {
    super.initState();
  }

  Future<double> getRadius() async {
    final f = await FirebaseAuth.instance.currentUser();
    final uid = f.uid;
    final document =
        await Firestore.instance.collection('Users').document(uid).get();
    final data = document.data;
    print("data" + data.toString());
    return data['radius'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: Appbar(),
        body: FutureBuilder<double>(
            future: getRadius(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                radius = snapshot.data;
                print(radius);
                return ListView(shrinkWrap: true, children: [
                  CustomBannerWidget(),
                  Padding(
                    padding: const EdgeInsets.all(10.0).copyWith(top: 10),
                    child: Text(
                      "Categories",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  CustomCategoriesSection(category: category),
                  GrocerySection(radius: radius?.toInt()),
                  RestaurentSection(radius: radius?.toInt()),
                  MedicalSection(radius: radius?.toInt()),
                ]);
              }
              return HomeSkeleton();
            }),
        drawer: CustomDrawer(url: url),
        bottomNavigationBar: BNavigation());
  }

  Appbar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset(
          "assets/menu.png",
          width: 20,
          height: 20,
        ),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      titleSpacing: 0,
      title: StreamBuilder<DocumentSnapshot>(
          stream: dataProvider.profile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return GestureDetector(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Delivery Address',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(112, 112, 122, 1),
                            fontSize: 12),
                      ),
                      Text(
                        '${snapshot.data['region']}',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(112, 112, 122, 1),
                            fontSize: 18),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => SelectRegion()));
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(child: Text("Some Error Occured"));
              }
              return Center(child: CircularProgressIndicator());
            }
          }),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0).copyWith(top: 2, bottom: 5),
          child: GestureDetector(
            onTap: () {
              showSearch(context: context, delegate: Search());
            },
            child: Container(
              padding: EdgeInsets.only(left: 8),
              height: 38,
              // width: 0.75*MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(02)),
                  border: Border.all(color: Color.fromRGBO(0, 211, 255, 1)),
                  color: Colors.white70),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Search Products"),
                    Spacer(),
                    Icon(Icons.search)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_active,
            color: Colors.blue,
            size: 30,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
