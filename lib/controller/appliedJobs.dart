import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nrega/model/statusChangeResponseModel.dart';
import 'package:nrega/model/viewJobsUserAppliedModel.dart';
import 'package:nrega/transaction/apiUrls.dart';
import 'package:nrega/transaction/request.dart';
import 'package:nrega/util/Connection.dart';
import 'package:nrega/util/Shared_Pref.dart';
import 'package:nrega/view/drawer.dart';

class AppliedJobs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppliedJobsClass();
  }
}

class AppliedJobsClass extends State<AppliedJobs> {
  bool _internetConnection = false;
  bool _setLoader = true;
  bool _lengthNull = false;
  String userId;
  String userType;
  List viewAllAppliedJobList;
  double leftColumnwidth = 0.35;
  double rightColumnwidth = 0.55;

  @override
  void initState() {
    super.initState();
    Future<String> p = SharedPreferencesTest.getUserId('userId');
    p.then((userid) {
      setState(() {
        userId = userid;
      });
    });
    Future<String> q = SharedPreferencesTest.getuserType('userType');
    q.then((usertype) {
      setState(() {
        userType = usertype;
      });
    });

    viewAppliedJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("View All Applied Jobs"),
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
                    itemCount: viewAllAppliedJobList == null
                        ? 0
                        : viewAllAppliedJobList.length,
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
                                  padding: EdgeInsets.all(10),
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
                                                viewAllAppliedJobList[i]
                                                    .jobName,
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
                                            child: Text(
                                                viewAllAppliedJobList[i].jobId,
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
                                              "User Id:",
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
                                                viewAllAppliedJobList[i].userId,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        136, 136, 136, 1))),
                                          ),
                                        ],
                                      ),
                                      viewAllAppliedJobList[i].adminStatus == 0
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: RaisedButton(
                                                        shape: new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    5.0)),
                                                        color: Colors.teal[300],
                                                        child: Text('Accept',
                                                            style: TextStyle(
                                                                fontSize: 20.0,
                                                                color: Colors
                                                                    .white)),
                                                        elevation: 6.0,
                                                        onPressed: () {
                                                          changeStatusOfJob(
                                                              viewAllAppliedJobList[
                                                                      i]
                                                                  .jobId,
                                                              viewAllAppliedJobList[
                                                                      i]
                                                                  .userId,
                                                              "1");
                                                        })),
                                                Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: RaisedButton(
                                                        shape: new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    5.0)),
                                                        color: Colors.pink,
                                                        child: Text('Reject',
                                                            style: TextStyle(
                                                                fontSize: 20.0,
                                                                color: Colors
                                                                    .white)),
                                                        elevation: 6.0,
                                                        onPressed: () {
                                                          changeStatusOfJob(
                                                              viewAllAppliedJobList[
                                                                      i]
                                                                  .jobId,
                                                              viewAllAppliedJobList[
                                                                      i]
                                                                  .userId,
                                                              "2");
                                                        })),
                                              ],
                                            )
                                          : Container(
                                              padding: EdgeInsets.all(10),
                                              child: Center(
                                                child: viewAllAppliedJobList[i]
                                                            .adminStatus ==
                                                        1
                                                    ? Text(
                                                        "✔ You have Accepted this job",
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 18),
                                                      )
                                                    : Text(
                                                        "❌ You have Rejected this job",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 18),
                                                      ),
                                              ))
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

  Future viewAppliedJobs() async {
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
        sendGetRequest(API().dummyUrl + API().viewJobsUserApplied)
            .then((response) {
          ViewJobsUserAppliedModel V =
              ViewJobsUserAppliedModel.fromJson(json.decode(response.body));
          if (V.code == 200) {
            viewAllAppliedJobList = V.data;
            // appliedJobInfo = V.data[1].apply;
            // for (var i = 0; i < appliedJobInfo.length; i++) {
            //   appliedJobId.add(appliedJobInfo[i].jobId);
            // }
            setState(() {
              _setLoader = false;
            });
          } else if (V.code == 404) {
            setState(() {
              _setLoader = false;
              _lengthNull = true;
            });
          } else {
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

  changeStatusOfJob(jobId, userId, status) {
    Future changeAdminStatusOfJob = sendPostRequest(
        API().dummyUrl + API().viewJobsUserApplied,
        {"jobId": jobId, "userId": userId, "status": status});
    changeAdminStatusOfJob.then((response) {
      print(response.body);
      print(json.decode(response.body));
      UpdateResponse U = UpdateResponse.fromJson(json.decode(response.body));
      if (U.code == 200) {
        Navigator.pushReplacementNamed(context, "/userAppliedJobs");
      } else {}
    });
  }
}
