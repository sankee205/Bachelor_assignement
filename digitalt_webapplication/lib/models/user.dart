class BaseUser {
  final String uid;
  final String fullName;
  final String email;
  final String userRole;

  BaseUser({this.uid, this.fullName, this.email, this.userRole});

  BaseUser.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        fullName = data['fullName'],
        email = data['email'],
        userRole = data['userRole'];
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'userRole': userRole,
    };
  }
}
