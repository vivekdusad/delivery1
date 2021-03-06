import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/model/data_provider.dart';
import 'package:delivery/screens/maps_page.dart';
import 'package:delivery/utils/const.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Cart.dart';

class OrderDetails extends StatefulWidget {
  final DocumentSnapshot snapshot;

  OrderDetails(this.snapshot);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<dynamic> orderlist = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10.withOpacity(0.95),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(0, 211, 225, 1),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.white),
        ),
        centerTitle: true,
        title: Text(
          "My Orders",
          style: GoogleFonts.poppins(color: Color.fromRGBO(0, 211, 225, 1)),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    color: Color.fromRGBO(0, 211, 225, 1), width: 1)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Order Id",
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      Text(
                        "${widget.snapshot.data['booking']}",
                        style: GoogleFonts.poppins(color: Colors.grey.shade400),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date of Booking",
                          style:
                              GoogleFonts.poppins(color: Colors.grey.shade400)),
                      Text(
                        "21 jan,at 10:30 pm",
                        style: GoogleFonts.poppins(),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Status",
                          style:
                              GoogleFonts.poppins(color: Colors.grey.shade400)),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4,
                        ),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff32CC34).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.all(4),
                            child: Text(
                              '${widget.snapshot.data['status']}',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Color(0xff32CC34),
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text("Shipping Address",
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.black)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text("${widget.snapshot.data['address']}",
                        style:
                            GoogleFonts.poppins(color: Colors.grey.shade400)),
                  ),
                  trailing: ImageIcon(AssetImage("assets/del.png"),
                      size: 40, color: Color.fromRGBO(0, 211, 225, 1)),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DottedBorder(
                    strokeWidth: 2,
                    color: blues,
                    child: ListTile(
                      onTap: () {
                        navigateToPage(context, MapsPage());
                      },
                      title: Text("Track Order",
                          style: GoogleFonts.poppins(
                              fontSize: 16, color: Colors.black)),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text("Track Delivery Boy",
                            style: GoogleFonts.poppins(
                                color: Colors.grey.shade400)),
                      ),
                      trailing: ImageIcon(AssetImage("assets/delivery-man.png"),
                          size: 40, color: Color.fromRGBO(0, 211, 225, 1)),
                    ),
                  ),
                ),
                Divider(),
                StreamBuilder<QuerySnapshot>(
                    stream: dataProvider.orderItems(widget.snapshot.documentID),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(bottom: 2),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.18,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top: 0,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: snapshot.data.documents[index]
                                                                  ['image'] !=
                                                              null &&
                                                          snapshot
                                                              .data
                                                              .documents[index]
                                                                  ['image']
                                                              .isNotEmpty
                                                      ? CachedNetworkImage(
                                                          imageUrl: snapshot
                                                                  .data
                                                                  .documents[index]
                                                              ['image'],
                                                          height:
                                                              MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                  0.18,
                                                          width: MediaQuery.of(context).size.width *
                                                              0.3,
                                                          fit: BoxFit.contain)
                                                      : Container(
                                                          alignment: Alignment.center,
                                                          height: MediaQuery.of(context).size.height * 0.18,
                                                          width: MediaQuery.of(context).size.width * 0.3,
                                                          child: Icon(Icons.photo_size_select_actual_outlined)),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 6,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                '${snapshot.data.documents[index]['name']}',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.5),
                                              ),
                                              subtitle: Text(
                                                snapshot.data.documents[index]
                                                        ['description'] ??
                                                    'Price for ${snapshot.data.documents[index]['quantity']}',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14.0),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade300),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                padding: EdgeInsets.all(6),
                                                child: Text(
                                                  '${snapshot.data.documents[index]['quantity']}',
                                                  style: GoogleFonts.poppins(),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8, top: 4),
                                              child: Row(
                                                children: [
                                                  Text(
                                                      '???${snapshot.data.documents[index]['price']}X${snapshot.data.documents[index]['pieces']} = ',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Colors
                                                                  .black)),
                                                  Text(
                                                      '???${snapshot.data.documents[index]['total']}',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xff00D3FF))),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            )
                                          ],
                                        ))
                                  ]),
                            );
                          },
                        );
                      }
                      if (snapshot.hasError) {}
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                CustomTile(
                    title: 'Items Total',
                    tail: '???${widget.snapshot.data['sub']}',
                    titlestyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 16),
                    tailstyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 16)),
                CustomTile(
                    title: 'Delivery Charge',
                    tail: '???${widget.snapshot.data['delivery']}',
                    titlestyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 16),
                    tailstyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 16)),
                CustomTile(
                    title: 'Sub Total',
                    tail:
                        '???${widget.snapshot.data['sub'] + widget.snapshot.data['delivery']}',
                    titlestyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 16),
                    tailstyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 16)),
                CustomTile(
                    title: 'Total Saving',
                    tail: '- ???${widget.snapshot.data['saving']}',
                    titlestyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 16),
                    tailstyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: blues,
                        fontSize: 16)),
                CustomTile(
                    title: 'Discount',
                    tail:
                        '${((widget.snapshot.data['saving'] / widget.snapshot.data['sub']) * 100).floor()}% OFF',
                    titlestyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 16),
                    tailstyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: blues,
                        fontSize: 16)),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Total:',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            'including all taxes',
                            style: GoogleFonts.poppins(
                              color: Color.fromRGBO(112, 112, 112, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "???${widget.snapshot.data['total']}",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
