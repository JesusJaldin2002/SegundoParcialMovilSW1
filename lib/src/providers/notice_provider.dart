import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/config/environment/environment.dart';
import 'package:segundo_parcial_movil_sw1/src/models/notice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticeProvider extends GetConnect {
  String url = Environment.apiUrl;

  Future<Map<String, dynamic>> createNotice(Notice notice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      try {
        final response = await post(
          '$url/api/notice/create',
          notice.toJson(),
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
          return {
            'success': true,
            'data': response.body['result'],
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

  Future<Map<String, dynamic>> getNotices(int cursoMateriaId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      try {
        final response = await get(
          '$url/api/notices/$cursoMateriaId',
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
          List<Notice> notices = List<Notice>.from(
              response.body.map((notice) => Notice.fromJson(notice))
          );
          return {
            'success': true,
            'data': notices,
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
