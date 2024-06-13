import 'dart:convert';

Courses coursesFromJson(String str) => Courses.fromJson(json.decode(str));

String coursesToJson(Courses data) => json.encode(data.toJson());

class Courses {
    int profesorId;
    String profesorName;
    List<Curso> cursos;
    Responsedetail responsedetail;

    Courses({
        required this.profesorId,
        required this.profesorName,
        required this.cursos,
        required this.responsedetail,
    });

    factory Courses.fromJson(Map<String, dynamic> json) => Courses(
        profesorId: json["profesor_id"],
        profesorName: json["profesor_name"],
        cursos: List<Curso>.from(json["cursos"].map((x) => Curso.fromJson(x))),
        responsedetail: Responsedetail.fromJson(json["responsedetail"]),
    );

    Map<String, dynamic> toJson() => {
        "profesor_id": profesorId,
        "profesor_name": profesorName,
        "cursos": List<dynamic>.from(cursos.map((x) => x.toJson())),
        "responsedetail": responsedetail.toJson(),
    };
}

class Curso {
    int cursoMateriaId;
    int cursoId;
    String cursoName;
    int materiaId;
    String materiaName;
    String schedule;
    int aulaId;
    String aulaName;

    Curso({
        required this.cursoMateriaId,
        required this.cursoId,
        required this.cursoName,
        required this.materiaId,
        required this.materiaName,
        required this.schedule,
        required this.aulaId,
        required this.aulaName,
    });

    factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        cursoMateriaId: json["curso_materia_id"],
        cursoId: json["curso_id"],
        cursoName: json["curso_name"],
        materiaId: json["materia_id"],
        materiaName: json["materia_name"],
        schedule: json["schedule"],
        aulaId: json["aula_id"],
        aulaName: json["aula_name"],
    );

    Map<String, dynamic> toJson() => {
        "curso_materia_id": cursoMateriaId,
        "curso_id": cursoId,
        "curso_name": cursoName,
        "materia_id": materiaId,
        "materia_name": materiaName,
        "schedule": schedule,
        "aula_id": aulaId,
        "aula_name": aulaName,
    };
}

class Responsedetail {
    String messages;
    int messagestype;
    int responsecode;

    Responsedetail({
        required this.messages,
        required this.messagestype,
        required this.responsecode,
    });

    factory Responsedetail.fromJson(Map<String, dynamic> json) => Responsedetail(
        messages: json["messages"],
        messagestype: json["messagestype"],
        responsecode: json["responsecode"],
    );

    Map<String, dynamic> toJson() => {
        "messages": messages,
        "messagestype": messagestype,
        "responsecode": responsecode,
    };
}