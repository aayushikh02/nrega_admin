import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nrega/model/loginModel.dart';
import 'dart:convert';
import 'package:nrega/transaction/apiUrls.dart';
import 'package:nrega/transaction/request.dart';
import 'package:nrega/util/Shared_Pref.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Container(
            child: ListView(children: <Widget>[
          // FImage(), //logo
          Padding(padding: EdgeInsets.only(top: 40.0)),
          Inputs(),
          // Loader(), //Input fields
        ])));
  }
}

class Inputs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InputFields();
  }
}

class InputFields extends State<Inputs> {
  String password;
  bool _validate = false;
  bool _validate1 = false;
  final userId = TextEditingController();
  final pass = TextEditingController();
  bool _hidePassword = true;
  var snackBar;

  @override
  void dispose() {
    super.dispose();
  }

  _toogleVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Connection.checkInternetConnection();
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            controller: userId,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "User Id",
              errorText: _validate ? 'Required' : null,
              prefixIcon: Icon(Icons.mail),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
            ),
            onChanged: (String value) {
              setState(() {
                _validate = false;
              });
            },
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 30.0)),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextField(
            controller: pass,
            obscureText: _hidePassword,
            decoration: InputDecoration(
              labelText: "Password",
              errorText: _validate1 ? 'Required' : null,
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                  onPressed: _toogleVisibility,
                  icon: _hidePassword
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility)),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
            ),
            onChanged: (String value) {
              setState(() {
                password = value;
                _validate1 = false;
              });
            },
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 30.0)),
        Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 0.15,
            child: Container(
                //  AbsorbPointer(
                // absorbing: isButtonNotDisabled,
                child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0)),
                    color: Colors.pink,
                    child: Text('Submit',
                        style: TextStyle(fontSize: 20.0, color: Colors.white)),
                    elevation: 6.0,
                    onPressed: () {
                      setState(() {
                        userId.text.isEmpty
                            ? _validate = true
                            : _validate = false;

                        pass.text.isEmpty
                            ? _validate1 = true
                            : _validate1 = false;
                      });

                      if (_validate1 == true || _validate == true) {
                        showSnackBar(context, "Fields cannot be empty");
                      } else {
                        Future loginRequest =
                            sendPostRequest(API().dummyUrl + API().login, {
                          "userId": userId.text,
                          "password": password.toString(),
                        });
                        loginRequest.then((response) {
                          print(response.body);
                          LoginModel L =
                              LoginModel.fromJson(json.decode(response.body));
                          if (L.code == 200) {
                            SharedPreferencesTest.setUserID(L.data.userId);
                            SharedPreferencesTest.setuserType(L.data.userType);
                            SharedPreferencesTest.setuserName(L.data.name);
                            Navigator.pushReplacementNamed(context, "/home");
                          } else {}
                        });
                      }
                    })))
      ],
    );
  }

  void showSnackBar(BuildContext context, String message) {
    snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
      backgroundColor: Colors.grey,
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
