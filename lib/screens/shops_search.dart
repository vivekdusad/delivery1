import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/components/horizantol_card.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'Fliter_Products.dart';

class ShopSearch extends StatefulWidget {
  final String filter;
  const ShopSearch({Key key, this.filter}) : super(key: key);

  @override
  _ShopSearchState createState() => _ShopSearchState();
}

class _ShopSearchState extends State<ShopSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          color: Color.fromRGBO(0, 211, 255, 1),
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        centerTitle: true,
        title: Text(
          '${widget.filter}',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 211, 255, 1),
              fontSize: 20),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0).copyWith(top: 2, bottom: 5),
            child: Container(
              padding: EdgeInsets.only(left: 8),
              height: 38,
              // width: 0.75*MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(02)),
                  border: Border.all(color: Color.fromRGBO(0, 211, 255, 1)),
                  color: Colors.white70),
              child: TextField(
                showCursor: true,
                textAlign: TextAlign.left,
                readOnly: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Color.fromRGBO(0, 211, 255, 1),
                  ),
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Color(0xFF666666),
                  ),
                  hintText: "Search your shop",
                ),
                onTap: () {
                  
                },
              ),
            ),
          ),
        ),
      ),
      body: PaginateFirestore(
        //item builder type is compulsory.
        itemBuilder: (index, context, documentSnapshot) {
          final data = documentSnapshot.data;
          return SizedBox(
            height: 200,
            child: HorizontalCard(
              image: data['image'],
              name: data['shopname'],
              address: data['address'],
              distance: data['distance'],
              rating: data['rating'],
              onClick: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            FilterProduct(snapshot: documentSnapshot)));
              },
            ),
          );
        },

        // orderBy is compulsory to enable pagination
        query: Firestore.instance
            .collection('Shops')
            .where('category', isEqualTo: widget.filter)
            .orderBy('shopname'),
        //Change types accordingly
        itemBuilderType: PaginateBuilderType.listView,
      ),
    );
  }
}
