import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/components/horizantol_card.dart';
import 'package:delivery/model/data_provider.dart';
import 'package:delivery/screens/Fliter_Products.dart';
import 'package:delivery/screens/shops_search.dart';
import 'package:delivery/utils/const.dart';
import 'package:flutter/material.dart';

class MedicalSection extends StatelessWidget {
  final int radius;
  const MedicalSection({
    this.radius,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: dataProvider.shops('Medical'),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.documents.length > 0) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Medical Store",
                        style: TextStyle(fontSize: 25),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => ShopSearch(
                                        filter: 'Medical',
                                      )));
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: RichText(
                              text: new TextSpan(
                                text: "See all >>",
                                style: new TextStyle(color: Colors.blue),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: 220),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/back2.png"),
                          fit: BoxFit.fitHeight)),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.documents.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return HorizontalCard(
                        image: snapshot.data.documents[index]['image'],
                        name: snapshot.data.documents[index]['shopname'],
                        address: snapshot.data.documents[index]['region'],
                        distance: snapshot.data.documents[index]['distance'],
                        rating: snapshot.data.documents[index]['rating'],
                        onClick: () {
                          navigateToPage(
                              context,
                              FilterProduct(
                                snapshot: snapshot.data.documents[index],
                              ));
                        },
                      );
                    },
                  ),
                )
              ],
            );
          }
          return Container();
        });
  }
}
