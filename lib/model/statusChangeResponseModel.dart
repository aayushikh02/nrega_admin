class UpdateResponse {
  String tag;
  int code;
  Data data;

  UpdateResponse({this.tag, this.code, this.data});

  UpdateResponse.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  int n;
  int nModified;
  int ok;

  Data({this.n, this.nModified, this.ok});

  Data.fromJson(Map<String, dynamic> json) {
    n = json['n'];
    nModified = json['nModified'];
    ok = json['ok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['n'] = this.n;
    data['nModified'] = this.nModified;
    data['ok'] = this.ok;
    return data;
  }
}
