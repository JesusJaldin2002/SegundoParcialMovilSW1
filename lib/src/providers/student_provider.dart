import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/config/environment/environment.dart';
import 'package:segundo_parcial_movil_sw1/src/models/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProvider extends GetConnect {
  String url = Environment.apiUrl;

  Future<Map<String, dynamic>> getStudents(int apoderadoId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      try {
        final response = await get(
          '$url/api/apoderado/students/$apoderadoId',
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        if (response.status.hasError) {
          return {
            'success': false,
            'message': response.body['error']['message'],
            'data': response.body['error']['data'],
          };
        } else {
          List<Student> students = List<Student>.from(
              response.body.map((student) => Student.fromJson(student))
          );
          return {
            'success': true,
            'data': students,
          };
        }
      } catch (e) {
        return {
          'success': false,
          'message': 'An error occurred',
          'data': e.toString(),
        };
      }
    }

    return {
      'success': false,
      'message': 'No autorizado',
      'data': null,
    };
  }
}
