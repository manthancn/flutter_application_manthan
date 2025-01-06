class CustomerModel {
  String? strFName;
  String? strLName;
  String? strEmail;
  String? strProfilePic;

  String get strFullName {
    return "${strFName ?? ''} ${strLName ?? ''}";
  }

  CustomerModel.fromJson(Map<String, dynamic> json)  {
    strFName = json["first_name"];
    strLName = json["last_name"];
    strEmail = json["email"];
    strProfilePic = json["profile_picture"];
  }
}
