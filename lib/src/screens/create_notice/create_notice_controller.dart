import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/providers/notice_provider.dart';
import 'package:segundo_parcial_movil_sw1/src/models/notice.dart';
import 'package:flutter/material.dart';

class CreateNoticeController extends GetxController {
  final NoticeProvider noticeProvider = NoticeProvider();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var fechaInicioController = TextEditingController();
  var fechaFinController = TextEditingController();

  var isLoading = false.obs;

  Future<void> createNotice(int id) async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    Notice notice = Notice(
      title: titleController.text,
      description: descriptionController.text,
      cursoMateriaId: id,
      fechaInicio: DateTime.parse(fechaInicioController.text),
      fechaFin: DateTime.parse(fechaFinController.text),
    );

    var response = await noticeProvider.createNotice(notice);

    isLoading.value = false;

    if (response['success']) {
      Get.snackbar('Éxito', 'Noticia creada con éxito', snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Error', 'No se pudo crear la noticia: ${response['message']}', snackPosition: SnackPosition.BOTTOM);
    }
  }
}