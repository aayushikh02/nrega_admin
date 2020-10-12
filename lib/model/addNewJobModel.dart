class AddNewJobModel {
  String tag;
  int code;
  String data;

  AddNewJobModel({this.tag, this.code, this.data});

  AddNewJobModel.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    code = json['code'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['code'] = this.code;
    data['data'] = this.data;
    return data;
  }
}
