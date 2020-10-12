// final project admin

import 'package:flutter/material.dart';
import 'package:nrega/controller/accepted.dart';
import 'package:nrega/controller/addNew.dart';
import 'package:nrega/controller/appliedJobs.dart';
import 'package:nrega/controller/home.dart';
import 'package:nrega/controller/login.dart';
import 'package:nrega/controller/rejected.dart';
import 'package:nrega/util/Shared_Pref.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var userId;
  Future<String> p = SharedPreferencesTest.getUserId('userId');
  p.then((userid) {
    userId = userid;
    print(userId);
    runApp(MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      routes: {
        "/home": (BuildContext context) => Home(),
        "/login": (BuildContext context) => Login(),
        "/addNewJob": (BuildContext context) => AddNewJob(),
        "/rejectedJob": (BuildContext context) => RejectedJob(),
        "/acceptedJob": (BuildContext context) => AcceptedJob(),
        "/userAppliedJobs": (BuildContext context) => AppliedJobs(),
      },
      home: userId.toString() == "undefined" ? Login() : Home(),
    ));
  });
}
