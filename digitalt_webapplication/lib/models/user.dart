class BaseUser {
  final String uid;
  final String fullName;
  final String email;
  final String phonenumber;
  final String userRole;

  BaseUser(
      {this.uid, this.fullName, this.email, this.phonenumber, this.userRole});

  BaseUser.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        fullName = data['fullName'],
        email = data['email'],
        phonenumber = data['phonenumber'],
        userRole = data['userRole'];
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phonenumber': phonenumber,
      'userRole': userRole,
    };
  }
}
