  class ViewJobsUserAppliedModel {
  String tag;
  int code;
  List<Data> data;

  ViewJobsUserAppliedModel({this.tag, this.code, this.data});

  ViewJobsUserAppliedModel.fromJson(Map<String, dynamic> json) {
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
  String userId;
  String jobId;
  int userResponse;
  String userType;
  int adminStatus;
  int iV;
  String jobName;

  Data(
      {this.sId,
      this.userId,
      this.jobId,
      this.userResponse,
      this.userType,
      this.adminStatus,
      this.iV,
      this.jobName});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    jobId = json['jobId'];
    userResponse = json['userResponse'];
    userType = json['userType'];
    adminStatus = json['adminStatus'];
    iV = json['__v'];
    jobName = json['jobName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['jobId'] = this.jobId;
    data['userResponse'] = this.userResponse;
    data['userType'] = this.userType;
    data['adminStatus'] = this.adminStatus;
    data['__v'] = this.iV;
    data['jobName'] = this.jobName;
    return data;
  }
}
