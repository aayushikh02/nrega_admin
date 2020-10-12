import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

errorMethod(codeError) {
  if (codeError == 403) {
    return 403; //token expire
  } else if (codeError == 401) {
    return 401; //data unauthorized
  } else if (codeError == 404) {
    return 404; //no record found
  } else if (codeError == 400) {
    return 400; //bad request
  } else if (codeError == 500) {
    return 500; //server error
  }
}

callToast(message, color) {
  Fluttertoast.showToast(
    msg: message,
    textColor: Colors.white,
    timeInSecForIos: 3,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: color,
  );
}

sendPostRequest(url, data) async {
  print(url);
  print(data);
  final responseee = await http.post(
    url,
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
    encoding: Encoding.getByName("utf-8"),
    body: data,
  );
  print("kajaja");
  try {
    if (responseee != null) {
      print("eree");
      return responseee;
    }
  } catch (e) {
    print("in error");
    return responseee;
  }
}

sendGetRequest(String url) async {
  print(url);
  final responsee = await http.get(url);
  try {
    if (responsee != null) {
      print(responsee.body);
      return responsee;
    }
  } catch (e) {
    return responsee;
  }
}

sendGetRequestWithParams(queryParams) async {
  print("1");
  var uri = Uri.https('http://192.168.43.2:8080/', 'job', queryParams);
  final responsee = await http.get(uri);
  print("2");
  print(responsee);
  try {
    if (responsee != null) {
      print(responsee.body);
      return responsee;
    }
  } catch (e) {
    return responsee;
  }
}
