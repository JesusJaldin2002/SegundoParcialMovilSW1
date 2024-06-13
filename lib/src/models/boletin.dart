import 'dart:convert';

List<Boletin> boletinFromJson(String str) => List<Boletin>.from(json.decode(str).map((x) => Boletin.fromJson(x)));

String boletinToJson(List<Boletin> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Boletin {
  int? boletinId;
  int? cursoId;
  String? cursoName;
  int? nroBimestre;
  int? studentId;
  DateTime? fecha;
  double? notaTotal;
  List<Nota>? notas;

  Boletin({
    this.boletinId,
    this.cursoId,
    this.cursoName,
    this.nroBimestre,
    this.studentId,
    this.fecha,
    this.notaTotal,
    this.notas,
  });

  factory Boletin.fromJson(Map<String, dynamic> json) => Boletin(
    boletinId: json["boletin_id"],
    cursoId: json["curso_id"],
    cursoName: json["curso_name"],
    nroBimestre: json["nro_bimestre"],
    studentId: json["student_id"],
    fecha: DateTime.parse(json["fecha"]),
    notaTotal: json["nota_total"].toDouble(),
    notas: List<Nota>.from(json["notas"].map((x) => Nota.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "boletin_id": boletinId,
    "curso_id": cursoId,
    "curso_name": cursoName,
    "nro_bimestre": nroBimestre,
    "student_id": studentId,
    "fecha": "${fecha?.year.toString().padLeft(4, '0')}-${fecha?.month.toString().padLeft(2, '0')}-${fecha?.day.toString().padLeft(2, '0')}",
    "nota_total": notaTotal,
    "notas": List<dynamic>.from(notas!.map((x) => x.toJson())),
  };
}

class Nota {
  int? cursoId;
  String? cursoName;
  int? materiaId;
  String? materiaName;
  int? nroBimestre;
  double? nota;

  Nota({
    this.cursoId,
    this.cursoName,
    this.materiaId,
    this.materiaName,
    this.nroBimestre,
    this.nota,
  });

  factory Nota.fromJson(Map<String, dynamic> json) => Nota(
    cursoId: json["curso_id"],
    cursoName: json["curso_name"],
    materiaId: json["materia_id"],
    materiaName: json["materia_name"],
    nroBimestre: json["nro_bimestre"],
    nota: json["nota"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "curso_id": cursoId,
    "curso_name": cursoName,
    "materia_id": materiaId,
    "materia_name": materiaName,
    "nro_bimestre": nroBimestre,
    "nota": nota,
  };
}
