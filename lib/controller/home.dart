import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nrega/model/viewAllJobModel.dart';
import 'package:nrega/transaction/apiUrls.dart';
import 'package:nrega/transaction/request.dart';
import 'package:nrega/util/Connection.dart';
import 'package:nrega/view/drawer.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeClass();
  }
}

class HomeClass extends State<Home> {
  bool _internetConnection = false;
  bool _setLoader = true;
  bool _lengthNull = false;
  List viewAllJobList;
  List appliedJobInfo;
  double leftColumnwidth = 0.35;
  double rightColumnwidth = 0.55;
  var date = "";
  bool showdeadline = false;
  var deadline;
  var dateSelected;
  List allJobList;

  @override
  void initState() {
    super.initState();
    viewJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: Drawer1(),
        body: _internetConnection
            ? _setLoader
                ? _lengthNull == true
                    ? Center(
                        child: Text(
                          "No Record Found",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 300),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                            Text(
                              "Loading...",
                            )
                          ],
                        ))
                : ListView.builder(
                    itemCount:
                        viewAllJobList == null ? 0 : viewAllJobList.length,
                    itemBuilder: (BuildContext context, i) {
                      return Column(children: <Widget>[
                        Container(
                            // height: MediaQuery.of(context).size.height * 0.09,
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.01,
                                top: MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.width * 0.01),
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                leftColumnwidth,
                                            child: Text(
                                              "Job Name:",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    88, 88, 88, 1),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                rightColumnwidth,
                                            child: Text(
                                                viewAllJobList[i].jobName,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        136, 136, 136, 1))),
                                          ),
                                        ],
                                      ),
                                      Divider(height: 5.0, color: Colors.grey),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                leftColumnwidth,
                                            child: Text(
                                              "Id:",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    88, 88, 88, 1),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                rightColumnwidth,
                                            child: Text(viewAllJobList[i].jobId,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        136, 136, 136, 1))),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                leftColumnwidth,
                                            child: Text(
                                              "Location:",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    88, 88, 88, 1),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                rightColumnwidth,
                                            child: Text(
                                                viewAllJobList[i].jobLocation,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        136, 136, 136, 1))),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                leftColumnwidth,
                                            child: Text(
                                              "Posted On:",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    88, 88, 88, 1),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                rightColumnwidth,
                                            child: Text(
                                                viewAllJobList[i].postedOn,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        136, 136, 136, 1))),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                leftColumnwidth,
                                            child: Text(
                                              "Deadline:",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromRGBO(
                                                    88, 88, 88, 1),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                rightColumnwidth,
                                            child: Text(
                                                viewAllJobList[i].deadline,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        136, 136, 136, 1))),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ))
                      ]);
                    })
            : Center(
                child: Text(
                  "No Internet Connection..!!",
                  style: TextStyle(fontSize: 20),
                ),
              ));
  }

  Future viewJobs() async {
    Future internetConnection = Connection.internet();
    internetConnection.then((onValue) {
      if (onValue == false) {
        setState(() {
          _internetConnection = false;
        });
      } else {
        setState(() {
          _internetConnection = true;
        });

        print("idhare");
        sendGetRequest(API().dummyUrl + API().viewAllJob).then((response) {
          print("in res");
          ViewAllJobModel V =
              ViewAllJobModel.fromJson(json.decode(response.body));
          print(V.code);
          if (V.code == 200) {
            print("yyy");
            viewAllJobList = V.data;
            print("pppppppppp");
            print(viewAllJobList);
            // appliedJobInfo = V.data[1].apply;
            // print(appliedJobInfo);
            setState(() {
              _setLoader = false;
            });
            print(viewAllJobList);
          } else if (V.code == 404) {
            setState(() {
              _setLoader = false;
              _lengthNull = true;
            });
          } else {
            print("ekse");
            setState(() {
              _setLoader = false;
            });
          }
        }).catchError((onError) {
          // callToast("Something went wrong...", Colors.yellow);
          debugPrint("errroorr");
        });
      }
    });
  }
}
