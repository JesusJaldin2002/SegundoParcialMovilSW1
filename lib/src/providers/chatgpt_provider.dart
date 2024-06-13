import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/models/chat_response.dart';
import 'package:segundo_parcial_movil_sw1/src/config/environment/environment.dart';

class ChatGPTProvider extends GetConnect {
  final String url = Environment.apiUrl;

  ChatGPTProvider() {
    httpClient.timeout = const Duration(seconds: 70);  // Increase timeout duration
    httpClient.defaultContentType = 'application/json';  // Set the default content type
  }

  Future<ChatResponse?> getChatGPTResponse(String tema, String materia, String descripcion) async {
    final response = await post(
      '$url/api/chatgpt',
      {
        'tema': tema,
        'materia': materia,
        'descripcion': descripcion,
      },
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.status.hasError) {
      return Future.error(response.statusText ?? 'Error fetching chat response');
    } else {
      return ChatResponse.fromJson(response.body);
    }
  }
}
