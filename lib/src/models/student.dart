import 'dart:convert';

List<Student> studentFromJson(String str) => List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

String studentToJson(List<Student> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Student {
    String studentName;
    String courseName;
    int userId;

    Student({
        required this.studentName,
        required this.courseName,
        required this.userId,
    });

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        studentName: json["student_name"],
        courseName: json["course_name"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "student_name": studentName,
        "course_name": courseName,
        "user_id": userId,
    };
}
