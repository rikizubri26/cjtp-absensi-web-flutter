class User {

  final String name;
  final String access_token;
  final String employee_id;
  final String job;

  User({this.name, this.access_token,this.employee_id,this.job});


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      access_token: json["access_token"],
      employee_id: json["employee_id"],
      job: json["job"],
    );
  }

}