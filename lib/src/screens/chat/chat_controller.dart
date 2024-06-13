import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/providers/chatgpt_provider.dart';
import 'package:segundo_parcial_movil_sw1/src/models/chat_response.dart';

class ChatController extends GetxController {
  final ChatGPTProvider chatGPTProvider = ChatGPTProvider();
  var chatResponse = Rxn<ChatResponse>();
  var isLoading = false.obs;

  void getChatResponse(String tema, String materia, String descripcion) async {
    isLoading.value = true;
    try {
      print('Fetching response for tema: $tema, materia: $materia, descripcion: $descripcion');
      final response = await chatGPTProvider.getChatGPTResponse(tema, materia, descripcion);
      if (response != null) {
        chatResponse.value = response;
      } else {
        Get.snackbar('Error', 'No response received from the server');
      }
    } catch (e) {
      print('Error occurred: $e');
      Get.snackbar('Error', 'An error occurred while fetching the response: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
