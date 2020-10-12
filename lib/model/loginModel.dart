class LoginModel {
  String tag;
  int code;
  Data data;

  LoginModel({this.tag, this.code, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    code = json['code'];
      try {
      data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    } catch (e) {
      return;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String sId;
  String userId;
  String password;
  String name;
  String userType;

  Data({this.sId, this.userId, this.password, this.name, this.userType});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    password = json['password'];
    name = json['name'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['password'] = this.password;
    data['name'] = this.name;
    data['userType'] = this.userType;
    return data;
  }
}
