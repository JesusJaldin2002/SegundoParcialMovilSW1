import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/config/environment/environment.dart';
import 'package:segundo_parcial_movil_sw1/src/models/student_inscribed.dart';
import 'package:segundo_parcial_movil_sw1/src/models/attendance_list.dart';
import 'dart:convert';

class AttendanceListProvider extends GetConnect {
  String url = Environment.apiUrl;

  Future<dynamic> getAttendanceLists(int cursoId) async {
    final response = await get('$url/api/attendance/lists/$cursoId');

    if (response.statusCode == 200) {
      List<AttendanceList> attendanceLists =
          attendanceListFromJson(response.bodyString ?? '[]');

      if (attendanceLists.isEmpty) {
        return 'Aún no hay listas de asistencias';
      }

      return attendanceLists;
    } else {
      throw Exception('Failed to load attendance lists');
    }
  }

  Future<dynamic> getInscribedStudents(int cursoId) async {
    final response = await get('$url/api/course/inscribed_students/$cursoId');

    if (response.statusCode == 200) {
      List<StudentInscribed> students =
          (json.decode(response.bodyString ?? '[]') as List)
              .map((data) => StudentInscribed.fromJson(data))
              .toList();

      if (students.isEmpty) {
        return 'No hay estudiantes inscritos en este curso';
      }

      return students;
    } else {
      throw Exception('Failed to load students');
    }
  }

  Future<dynamic> createAttendanceList(int cursoId, String fecha) async {
    final response = await post('$url/api/attendance/create/$cursoId', {
      'fecha': fecha,
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.bodyString ?? '{}');
      if (body.containsKey('error')) {
        return {
          'success': false,
          'message': body['error']['message'],
        };
      } else {
        return {
          'success': true,
          'data': body['result'],
        };
      }
    } else {
      return {
        'success': false,
        'message': 'Failed to create attendance list',
      };
    }
  }

  Future<dynamic> saveAttendance(int listaId, int studentId, String estado, String observacion) async {
    final response = await post(
      '$url/api/attendance/save',
      json.encode({
        'lista_id': listaId,
        'student_id': studentId,
        'estado': estado,
        'observacion': observacion,
      }),
    );

    if (response.statusCode == 200) {
      return response.body['result']['result'];
    } else {
      throw Exception('Failed to save attendance');
    }
  }
}
