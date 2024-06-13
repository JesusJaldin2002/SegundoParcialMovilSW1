import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/models/notice.dart';
import 'package:segundo_parcial_movil_sw1/src/providers/notice_provider.dart';

class NoticesController extends GetxController {
  var isLoading = false.obs;
  var notices = <Notice>[].obs;
  var filteredNotices = <Notice>[].obs;
  NoticeProvider noticeProvider = NoticeProvider();

  void fetchNotices(int cursoMateriaId) async {
    isLoading.value = true;
    var response = await noticeProvider.getNotices(cursoMateriaId);
    if (response['success']) {
      notices.value = List<Notice>.from(response['data']);
      filteredNotices.value = notices; // Initially, show all notices
    } else {
      // Manejar errores si es necesario
      Get.snackbar('Error', response['message']);
    }
    isLoading.value = false;
  }

  void filterNotices(DateTime startDate, DateTime endDate) {
    filteredNotices.value = notices.where((notice) {
      return notice.fechaFin != null &&
          (notice.fechaFin!.isAtSameMomentAs(startDate) ||
           notice.fechaFin!.isAtSameMomentAs(endDate) ||
           (notice.fechaFin!.isAfter(startDate) && notice.fechaFin!.isBefore(endDate)));
    }).toList();
  }
}
