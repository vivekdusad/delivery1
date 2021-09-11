import 'package:delivery/screens/shops_search.dart';
import 'package:delivery/utils/const.dart';
import 'package:delivery/utils/data.dart';
import 'package:flutter/material.dart';

class CustomCategoriesSection extends StatelessWidget {
  const CustomCategoriesSection({
    Key key,
    @required this.category,
  }) : super(key: key);

  final List<Categories> category;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: <Widget>[
        for (var item in category)
          GestureDetector(
            onTap: () {
              if (item.name == 'Grocery') {
                navigateToPage(
                    context,
                    ShopSearch(
                      filter: 'Grocery',
                    ));
              } else if (item.name == 'Food') {
                navigateToPage(
                    context,
                    ShopSearch(
                      filter: 'Restaurant',
                    ));
              } else if (item.name == 'Veg and Fruits') {
                navigateToPage(
                    context,
                    ShopSearch(
                      filter: 'Veg and Fruits',
                    ));
              } else if (item.name == 'Medicines') {
                navigateToPage(
                    context,
                    ShopSearch(
                      filter: 'Medical',
                    ));
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Card(
                    elevation: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          image: DecorationImage(
                              image: AssetImage(item.image),
                              fit: BoxFit.fitHeight),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Text(
                  item.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
      ]),
    );
  }
}
