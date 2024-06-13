import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/config/environment/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursesProvider extends GetConnect {
  String url = Environment.apiUrl;

  Future<Response> getOfferts(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      Response response = await get(
        '$url/api/courses/$id', // Reemplaza con la URL de tu API
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      return response;
    }

    return const Response(statusCode: 401, body: 'No autorizado');
  }

  
}