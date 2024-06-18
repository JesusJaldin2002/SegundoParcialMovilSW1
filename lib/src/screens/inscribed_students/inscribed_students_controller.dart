import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/models/student_inscribed.dart';
import 'package:segundo_parcial_movil_sw1/src/providers/attendance_list_provider.dart';

class InscribedStudentsController extends GetxController {
  final AttendanceListProvider provider = AttendanceListProvider();
  var students = <StudentInscribed>[].obs;
  var isLoading = false.obs;
  var message = ''.obs;

  void fetchInscribedStudents(int cursoId) async {
    isLoading.value = true;
    try {
      var result = await provider.getInscribedStudents(cursoId);
      if (result is String) {
        message.value = result;
      } else if (result is List<StudentInscribed>) {
        students.value = result;
        message.value = '';
      }
    } catch (e) {
      message.value = 'Error al cargar los estudiantes';
    } finally {
      isLoading.value = false;
    }
  }
}
