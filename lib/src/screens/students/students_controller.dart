import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/models/student.dart';
import 'package:segundo_parcial_movil_sw1/src/providers/student_provider.dart';

class StudentsController extends GetxController {
  StudentProvider studentProvider = StudentProvider();
  var students = <Student>[].obs;
  var isLoading = false.obs;

  Future<void> fetchStudents(int apoderadoId) async {
    isLoading.value = true;
    var result = await studentProvider.getStudents(apoderadoId);
    if (result['success']) {
      students.value = result['data'];
    } else {
      Get.snackbar('Error', result['message']);
    }
    isLoading.value = false;
  }
}
