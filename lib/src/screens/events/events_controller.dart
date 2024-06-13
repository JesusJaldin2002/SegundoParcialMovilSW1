import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/models/notice.dart';
import 'package:segundo_parcial_movil_sw1/src/providers/notice_provider.dart';

class EventsController extends GetxController {
  NoticeProvider noticeProvider = NoticeProvider();

  var events = <Notice>[].obs;
  var filteredEvents = <Notice>[].obs;
  var isLoading = false.obs;

  void fetchEvents(int userId) async {
    isLoading.value = true;
    final result = await noticeProvider.getNoticesByUser(userId);

    if (result['success']) {
      List<Notice> fetchedEvents = result['data'];
      fetchedEvents.sort((a, b) => a.fechaFin!.compareTo(b.fechaFin!));
      events.value = fetchedEvents;
      filteredEvents.value = fetchedEvents;
    } else {
      Get.snackbar('Error', 'An error occurred while fetching events');
    }

    isLoading.value = false;
  }

  void filterEvents(DateTime startDate, DateTime endDate) {
    filteredEvents.value = events.where((event) {
      return event.fechaFin != null &&
          event.fechaFin!.isAfter(startDate) &&
          event.fechaFin!.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }
}
