import 'dart:convert';

Notice noticeFromJson(String str) => Notice.fromJson(json.decode(str));

String noticeToJson(Notice data) => json.encode(data.toJson());

class Notice {
  String title;
  String description;
  int cursoMateriaId;
  DateTime? fechaInicio;
  DateTime? fechaFin;
  String? profesor;
  String? curso;
  String? materia;

  Notice({
    required this.title,
    required this.description,
    required this.cursoMateriaId,
    this.fechaInicio,
    this.fechaFin,
    this.profesor,
    this.curso,
    this.materia,
  });

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
    title: json["title"],
    description: json["description"],
    cursoMateriaId: json["curso_materia_id"],
    fechaInicio: json["fecha_inicio"] != null ? DateTime.parse(json["fecha_inicio"]) : null,
    fechaFin: json["fecha_fin"] != null ? DateTime.parse(json["fecha_fin"]) : null,
    profesor: json["profesor"],
    curso: json["curso"],
    materia: json["materia"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "curso_materia_id": cursoMateriaId,
    "fecha_inicio": fechaInicio != null ? "${fechaInicio!.year.toString().padLeft(4, '0')}-${fechaInicio!.month.toString().padLeft(2, '0')}-${fechaInicio!.day.toString().padLeft(2, '0')}" : null,
    "fecha_fin": fechaFin != null ? "${fechaFin!.year.toString().padLeft(4, '0')}-${fechaFin!.month.toString().padLeft(2, '0')}-${fechaFin!.day.toString().padLeft(2, '0')}" : null,
    "profesor": profesor,
    "curso": curso,
    "materia": materia,
  };
}
