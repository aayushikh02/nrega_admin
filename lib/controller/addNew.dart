import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nrega/model/addNewJobModel.dart';
import 'package:nrega/transaction/apiUrls.dart';
import 'package:nrega/transaction/request.dart';
import 'package:nrega/view/drawer.dart';

class AddNewJob extends StatefulWidget {
  bool allowedtoAccess = false;
  @override
  State<StatefulWidget> createState() {
    return AddNewJobClass();
  }
}

class AddNewJobClass extends State<AddNewJob> {
  var jobName = TextEditingController();
  var jobId = TextEditingController();
  var jobLocation = TextEditingController();
  var postedOn = TextEditingController();
  var deadline;
  bool _validate = false;
  bool _validate1 = false;
  bool _validate2 = false;

  DateTime _date = DateTime.now();
  var date = "";
  bool showdeadline = false;
  var dateSelected;
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _date) {
      int selectDay = picked.day;
      int selectMonth = picked.month;
      int selectYear = picked.year;
      dateSelected = "$selectDay" + "-" + "$selectMonth" + "-" + "$selectYear";
      print(dateSelected);
      setState(() {
        _date = picked;
        deadline = dateSelected.toString();
        print(deadline);
        showdeadline = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    int day = DateTime.now().day;
    int month = DateTime.now().month;
    int year = DateTime.now().year;
    postedOn.text = "$day" + "-" + "$month" + "-" + "$year";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Job"),
      ),
      drawer: Drawer1(),
      body: Builder(
          builder: (context) => Center(
                  child: Stack(children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 6.0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 12.0),
                        child: ListView(
                          children: <Widget>[
                            TextField(
                              controller: jobName,
                              decoration: InputDecoration(
                                labelText: "Job Name",
                                errorText:
                                    _validate ? 'Value Can\'t Be Empty' : null,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(15.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _validate = false;
                                });
                              },
                            ),
                            Padding(padding: EdgeInsets.only(top: 20.0)),
                            TextField(
                              controller: jobId,
                              decoration: InputDecoration(
                                labelText: "Job Id",
                                errorText:
                                    _validate1 ? 'Value Can\'t Be Empty' : null,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(15.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _validate1 = false;
                                });
                              },
                            ),
                            Padding(padding: EdgeInsets.only(top: 20.0)),
                            TextField(
                              controller: jobLocation,
                              decoration: InputDecoration(
                                labelText: "Job Location",
                                errorText:
                                    _validate2 ? 'Value Can\'t Be Empty' : null,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(15.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  _validate2 = false;
                                });
                              },
                            ),
                            Padding(padding: EdgeInsets.only(top: 20.0)),
                            TextField(
                              controller: postedOn,
                              enabled: widget.allowedtoAccess,
                              decoration: InputDecoration(
                                labelText: "Posted On",
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(15.0),
                                  borderSide: new BorderSide(),
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20.0)),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  child: SimpleDialogOption(
                                    onPressed: () {
                                      _selectDate(context);
                                    },
                                    child: Text(
                                      "Select Deadline",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(88, 88, 88, 1),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                showdeadline
                                    ? Container(
                                        child: Text(deadline,
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    136, 136, 136, 1))))
                                    : Container()
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(top: 40.0)),
                            ButtonTheme(
                              minWidth: 50.0,
                              height: 50.0,
                              child: RaisedButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(15.0)),
                                  color: Colors.pink,
                                  child: Text("Add",
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white)),
                                  elevation: 3.0,
                                  onPressed: () {
                                    print("yeee");
                                    setState(() {
                                      jobName.text.isEmpty
                                          ? _validate = true
                                          : _validate = false;
                                      jobId.text.isEmpty
                                          ? _validate1 = true
                                          : _validate1 = false;
                                      jobLocation.text.isEmpty
                                          ? _validate2 = true
                                          : _validate2 = false;

                                      print("yhs");
                                    });
                                    if (_validate == true ||
                                        _validate1 == true ||
                                        _validate2 == true) {
                                      callToast(
                                          "Please fill all the fields", "red");
                                    } else {
                                      addNewJob();
                                    }
                                  }),
                            ),
                            Padding(padding: EdgeInsets.only(top: 40.0)),
                          ],
                        ),
                      ),
                    )),
              ]))),
    );
  }

  addNewJob() {
    Future addNewJob = sendPostRequest(API().dummyUrl + API().addNewJob, {
      "jobName": jobName.text,
      "jobId": jobId.text,
      "jobLocation": jobLocation.text,
      "postedOn": postedOn.text,
      "deadline": deadline
    });
    addNewJob.then((response) {
      print(response.body);
      AddNewJobModel N = AddNewJobModel.fromJson(json.decode(response.body));
      if (N.code == 200) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {}
    });
  }
}
