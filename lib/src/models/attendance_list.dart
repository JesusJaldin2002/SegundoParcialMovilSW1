import 'dart:convert';

// Función para convertir de JSON a una lista de AttendanceList
List<AttendanceList> attendanceListFromJson(String str) => 
    List<AttendanceList>.from(json.decode(str).map((x) => AttendanceList.fromJson(x)));

// Función para convertir de una lista de AttendanceList a JSON
String attendanceListToJson(List<AttendanceList> data) => 
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttendanceList {
  int id;
  DateTime fecha;
  int cursoId;
  String cursoName;

  AttendanceList({
    required this.id,
    required this.fecha,
    required this.cursoId,
    required this.cursoName,
  });

  factory AttendanceList.fromJson(Map<String, dynamic> json) => AttendanceList(
    id: json["id"],
    fecha: DateTime.parse(json["fecha"]),
    cursoId: json["curso_id"],
    cursoName: json["curso_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
    "curso_id": cursoId,
    "curso_name": cursoName,
  };
}
