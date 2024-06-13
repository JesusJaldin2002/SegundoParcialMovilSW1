// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/providers/boletin_provider.dart';
import 'package:segundo_parcial_movil_sw1/src/models/boletin.dart';

class BoletinController extends GetxController {
  final BoletinProvider boletinProvider = BoletinProvider();
  var boletines = <Boletin>[].obs;
  var isLoading = false.obs;
  final int userId;

  BoletinController({required this.userId});

  @override
  void onInit() {
    super.onInit();
    fetchBoletines(userId);
  }

  void fetchBoletines(int userId) async {
    isLoading.value = true;
    try {
      print('Fetching boletines for userId: $userId');
      final fetchedBoletines = await boletinProvider.getBoletines(userId);
      if (fetchedBoletines.isNotEmpty) {
        print('Fetched ${fetchedBoletines.length} boletines');
        fetchedBoletines.sort((a, b) => a.fecha!.compareTo(b.fecha!));
        boletines.value = fetchedBoletines;
      } else {
        print('No boletines found');
        Get.snackbar('Información', 'No hay boletines disponibles para este estudiante');
      }
    } catch (e) {
      print('Error occurred while fetching boletines: $e');
      Get.snackbar('Información', 'No hay boletines disponibles para este estudiante');
    } finally {
      isLoading.value = false;
    }
  }

  Boletin? getBoletinById(int boletinId) {
    return boletines.firstWhereOrNull((boletin) => boletin.boletinId == boletinId);
  }
}
