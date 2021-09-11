import 'package:flutter/material.dart';

class VerticalCard extends StatelessWidget {
  const VerticalCard(
      {Key key,
      this.image,
      this.name,
      this.address,
      this.distance,
      this.rating,
      this.onClick})
      : super(key: key);
  final String image;
  final String name;
  final String address;
  final String distance;
  final String rating;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          left: 8.0,
        ),
        child: GestureDetector(
          onTap: (){
            onClick();
          },
          child: Container(
            height: 100,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey[900].withOpacity(0.9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            address,
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            rating ?? "4.5",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "15Min",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.fill)),
          ),
        ));
  }
}
/*Container(
          width: MediaQuery.of(context).size.width*0.9,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(                    
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: CachedNetworkImage(
                              imageUrl: image,
                              height: 200,
                              fit: BoxFit.cover),
                        ),
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(icon: Icon(Icons.favorite,color: Colors.white,size: 35),
                                onPressed: (){

                                }),
                            Padding(padding: const EdgeInsets.only(bottom: 10.0, right: 8.0),
                              child: Container(decoration: BoxDecoration(
                                    borderRadius: new BorderRadius.all(Radius.circular(2)),
                                    color: Color.fromRGBO(255, 255, 225, 0.6)),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.all(
                                      6.0),
                                  child: Text("15 MIN"),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
                ListTile(title: Text("$name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Avenir", fontSize: 20)),
                  subtitle: Text("$address"),
                  trailing: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.end,
                    children: [
                      Text("$rating/5",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Avenir",
                              fontSize: 20)),
                      Text("10")
                    ],
                  ),),
              ],
            )
        ),),*/