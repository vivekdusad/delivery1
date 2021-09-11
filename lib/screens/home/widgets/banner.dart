import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/main.dart';
import 'package:flutter/material.dart';

class CustomBannerWidget extends StatelessWidget {
  const CustomBannerWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('Banners')
        .where('screen', isEqualTo: 'slide').snapshots(),
      builder: (context,snapshot){
      
      if(snapshot.hasData){
        return Container(
      height: 150,
      child: Carousel(
          images: banners
              .map((e) => CachedNetworkImage(
                    imageUrl: e.image,
                    fit: BoxFit.fill,
                  ))
              .toList(),
          dotBgColor: Colors.transparent,
          dotSize: 4,
          autoplayDuration: Duration(seconds: 5),
          onImageTap: (index) async {}),
    );
      }
      return Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
      );
    });
  }
}
