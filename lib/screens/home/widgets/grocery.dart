import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/components/horizantol_card.dart';
import 'package:delivery/screens/Fliter_Products.dart';
import 'package:delivery/screens/shops_search.dart';
import 'package:delivery/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class GrocerySection extends StatelessWidget {
  final int radius;
  const GrocerySection({
    Key key,
    this.radius =5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var collectionReference = Firestore.instance
        .collection('Shops');

    String field = 'position';
    final geo = Geoflutterfire();

    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: collectionReference)
        .within(
            center: geo.point(latitude: 26.5616517, longitude: 76.329175),
            radius: radius+0.0,
            field: field);
    return StreamBuilder<List<DocumentSnapshot>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Groceries",
                        style: TextStyle(fontSize: 25),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => ShopSearch(
                                        filter: 'Grocery',
                                      )));
                        },
                        child: Text(
                          "See all >>",
                          style: new TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: 220),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/background.png"),
                          fit: BoxFit.fitHeight)),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      // snapshot.data[index].data
                      return HorizontalCard(
                        image: snapshot.data[index].data['image'],
                        name: snapshot.data[index].data['shopname'],
                        address: snapshot.data[index].data['region'],
                        distance: snapshot.data[index].data['distance'],
                        rating: snapshot.data[index].data['rating'],
                        onClick: () {
                          navigateToPage(
                              context,
                              FilterProduct(
                                snapshot: snapshot.data[index],
                              ));
                        },
                      );
                    },
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
