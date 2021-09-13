import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/model/data_provider.dart';
import 'package:delivery/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home/home.dart';

class SelectRegion extends StatefulWidget {
  @override
  _SelectRegionState createState() => _SelectRegionState();
}

class _SelectRegionState extends State<SelectRegion> {
  double radius = 50;
  String field = 'position';
  final geo = Geoflutterfire();
  var collectionReference = Firestore.instance.collection('Regions');
  Stream<List<DocumentSnapshot>> stream;
  @override
  void initState() {
    stream = geo
        .collection(collectionRef: collectionReference)
        .within(
            center: geo.point(latitude: 26.5616517, longitude: 76.329175),
            radius: radius,
            field: field);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Select Your Region',
            style: GoogleFonts.poppins(color: Color(0xff00D3FF)),
          ),
        ),
        body: Stack(
          children: [
            StreamBuilder<List<DocumentSnapshot>>(
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text(
                            '${snapshot.data[index].data['region']}',
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                          onTap: () {
                            _upload(
                                snapshot.data[index].data['city'],
                                snapshot.data[index].data['region'],
                                snapshot.data[index].data['pincode'],
                                snapshot.data[index].data['delivery'],
                                snapshot.data[index].data['radius'] ,                                
                                );
                          },
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text(
                      "Use Your Current Location",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.location_searching,
                          color: Colors.white,
                        ))
                  ],
                ),
                width: double.infinity,
                color: blues,
              ),
            )
          ],
        ));
  }

  Future _upload(
      String city, String region, String pinCode, String delivery,int raduis) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.amber,
            ),
          );
        },
        barrierDismissible: false);
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    CollectionReference reference = Firestore.instance.collection('Users');
    try {
      reference.document(user.uid).setData({
        'city': city,
        'region': region,
        'pincode': pinCode,
        'radius':radius,
      }, merge: true);
      await UserData.getRegion();
      Navigator.pop(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    } catch (e) {
      print(e.toString());
    }
  }
}
