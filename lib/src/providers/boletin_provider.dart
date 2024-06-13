import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/models/boletin.dart';
import 'package:segundo_parcial_movil_sw1/src/config/environment/environment.dart';

class BoletinProvider extends GetConnect {
  final String url = Environment.apiUrl;

  Future<List<Boletin>> getBoletines(int userId) async {
    final response = await get('$url/api/boletin/$userId');
    if (response.status.hasError) {
      return Future.error(response.statusText ?? 'Error fetching boletines');
    } else {
      List<dynamic> body = response.body;
      return body.map((dynamic item) => Boletin.fromJson(item)).toList();
    }
  }
}
