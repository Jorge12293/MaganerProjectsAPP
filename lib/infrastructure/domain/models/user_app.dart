import 'dart:convert';

List<UserApp> responseListUserFromJson(String str) => List<UserApp>.from(json.decode(str).map((x) => UserApp.fromJson(x)));

class UserApp {
    int? userId;
    String uid;
    String username;
    String email;


    UserApp({
        this.userId,
        required this.uid,
        required this.username,
        required this.email,
    });

    factory UserApp.fromRawJson(String str) => UserApp.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserApp.fromJson(Map<String, dynamic> json) => UserApp(
        userId: json["userId"],
        uid: json["uid"],
        username: json["username"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "uid": uid,
        "username": username,
        "email": email
    };
}
