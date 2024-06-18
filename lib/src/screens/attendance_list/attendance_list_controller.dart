import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/models/attendance_list.dart';
import 'package:segundo_parcial_movil_sw1/src/providers/attendance_list_provider.dart';
import 'package:intl/intl.dart';

class AttendanceListController extends GetxController {
  final AttendanceListProvider provider = AttendanceListProvider();
  var attendanceLists = <AttendanceList>[].obs;
  var isLoading = false.obs;
  var message = ''.obs;

  void setCursoId(int cursoId) async {
    isLoading.value = true;
    try {
      var result = await provider.getAttendanceLists(cursoId);
      if (result is String) {
        message.value = result;
      } else if (result is List<AttendanceList>) {
        attendanceLists.value = result;
        message.value = '';
      }
    } catch (e) {
      message.value = 'Error al cargar las listas de asistencia';
    } finally {
      isLoading.value = false;
    }
  }

  void createAttendanceList(int cursoId) async {
    isLoading.value = true;
    try {
      String fecha = DateFormat('yyyy-MM-dd').format(DateTime.now());
      var result = await provider.createAttendanceList(cursoId, fecha);
      if (result['success']) {
        setCursoId(cursoId); // Refresh the attendance lists
        Get.snackbar('Success', 'Lista de asistencia creada con éxito');
      } else {
        Get.snackbar('Error', result['message'] ?? 'Error al crear la lista de asistencia');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error al crear la lista de asistencia');
    } finally {
      isLoading.value = false;
    }
  }
}
