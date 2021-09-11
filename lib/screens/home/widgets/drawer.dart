import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/model/data_provider.dart';
import 'package:delivery/screens/Profile.dart';
import 'package:delivery/screens/contact.dart';
import 'package:delivery/screens/login.dart';
import 'package:delivery/screens/myorders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  final String url;
  const CustomDrawer({Key key,this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 110,
              height: 110,
              padding: EdgeInsets.all(4),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child:ClipRRect(
                  borderRadius: BorderRadius.circular(70.0),
                  child: url != null && url.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.contain,
                        )
                      : CircleAvatar(
                          radius: 67,
                          backgroundColor: Color(0xff00D3FF),
                          child:
                              Icon(Icons.person, size: 45, color: Colors.white),
                        ),
                ),
              
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              UserData.name ?? 'Guest',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
            child: Center(
                child: Text(
              UserData.user.phoneNumber.toString() ?? '+91 xxxxxxxx',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
            )),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            title: Text('Home',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
            },
            contentPadding:
                EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person_outline,
              color: Colors.black,
            ),
            title: Text('Account',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Profile()));
            },
            contentPadding:
                EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
            title: Text('Orders',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MyOrders()));
            },
            contentPadding:
                EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.support_agent,
              color: Colors.black,
            ),
            title: Text('Contact US',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ContactUS()));
            },
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
          ),
          ListTile(
            title: Text('Sign Out',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
            leading: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onTap: () async {
              FirebaseAuth auth = FirebaseAuth.instance;
              await auth.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Login()));
            },
            trailing: Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
          ),
          ListTile(
            title: Text('Terms of Use',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
            onTap: () {},
          ),
          ListTile(
            title: Text('Privacy policy',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
