import 'package:flutter/material.dart';
import 'package:nrega/util/Shared_Pref.dart';

class Drawer1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Drawer2();
  }
}

class Drawer2 extends State<Drawer1> {
  List environmentList = [];
  String userType;
  List r;

  @override
  void initState() {
    super.initState();
    Future<String> q = SharedPreferencesTest.getuserType('userType');
    q.then((usertype) {
      setState(() {
        userType = usertype;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.zero,
        color: Color.fromRGBO(235, 235, 235, 1),
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          shrinkWrap: true,
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(0),
              child: Container(
                  color: Colors.pink,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Welcome Admin !",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(0)),
                    ],
                  )),
            ),
            ListTile(
              leading: ImageIcon(
                new AssetImage('assetss/submenu_icon.png'),
                color: Color.fromRGBO(136, 136, 136, 1),
              ),
              title: Text(
                'Posted Jobs',
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home', (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: ImageIcon(
                new AssetImage('assetss/submenu_icon.png'),
                color: Color.fromRGBO(136, 136, 136, 1),
              ),
              title: Text(
                'Add New Job',
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/addNewJob', (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: ImageIcon(
                new AssetImage('assetss/submenu_icon.png'),
                color: Color.fromRGBO(136, 136, 136, 1),
              ),
              title: Text(
                'Applied Jobs',
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/userAppliedJobs', (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: ImageIcon(
                new AssetImage('assetss/submenu_icon.png'),
                color: Color.fromRGBO(136, 136, 136, 1),
              ),
              title: Text(
                'Accepted Job',
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/acceptedJob', (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: ImageIcon(
                new AssetImage('assetss/submenu_icon.png'),
                color: Color.fromRGBO(136, 136, 136, 1),
              ),
              title: Text(
                'Rejected Job',
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/rejectedJob', (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: ImageIcon(
                new AssetImage('assetss/submenu_icon.png'),
                color: Color.fromRGBO(136, 136, 136, 1),
              ),
              title: Text(
                'Logout',
              ),
              onTap: () async {
                Navigator.pop(context);
                SharedPreferencesTest.remove();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
