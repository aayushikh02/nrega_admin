class ViewAllJobModel {
  String tag;
  int code;
  List<Data> data;

  ViewAllJobModel({this.tag, this.code, this.data});

  ViewAllJobModel.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    code = json['code'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String sId;
  String jobName;
  String jobId;
  String jobLocation;
  String postedOn;
  String deadline;
  int iV;

  Data(
      {this.sId,
      this.jobName,
      this.jobId,
      this.jobLocation,
      this.postedOn,
      this.deadline,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    jobName = json['jobName'];
    jobId = json['jobId'];
    jobLocation = json['jobLocation'];
    postedOn = json['postedOn'];
    deadline = json['deadline'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['jobName'] = this.jobName;
    data['jobId'] = this.jobId;
    data['jobLocation'] = this.jobLocation;
    data['postedOn'] = this.postedOn;
    data['deadline'] = this.deadline;
    data['__v'] = this.iV;
    return data;
  }
}
