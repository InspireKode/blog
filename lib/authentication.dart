

class RUser {
  String username, user_id, email;
  RUser({required this.username, required this.user_id, required this.email});
  factory RUser.fromJson(Map<String, dynamic> json) {
    return RUser(
        username: json['username'],
        user_id: json['user_id'],
        email: json['email']);
  }
}
class UserModel {
String uid;
UserModel({required this.uid});
}