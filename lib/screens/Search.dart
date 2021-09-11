import 'package:delivery/components/product_view.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Icon(Icons.search),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Container();
    }
    return PaginateFirestore(
      //item builder type is compulsory.
      itemBuilder: (index, context, documentSnapshot) {
        final data = documentSnapshot.data;
        return ProductView(
          snapshot: documentSnapshot,
          addCart: () {},
        );
      },

      // orderBy is compulsory to enable pagination
      query: Firestore.instance
          .collection('Products')
          .where('name', isGreaterThanOrEqualTo: query).orderBy('name'),
      //Change types accordingly
      itemBuilderType: PaginateBuilderType.listView,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 3) {
      return Container();
    }
    return PaginateFirestore(
      //item builder type is compulsory.
      itemBuilder: (index, context, documentSnapshot) {
        final data = documentSnapshot.data;
        return ProductView(
          snapshot: documentSnapshot,
          addCart: () {},
        );
      },

      // orderBy is compulsory to enable pagination
      query: Firestore.instance
          .collection('Products')
          .where('name', isGreaterThanOrEqualTo: query[0].toUpperCase()+query.substring(1)).orderBy('name'),
      //Change types accordingly
      itemBuilderType: PaginateBuilderType.listView,
    );
  }
}
