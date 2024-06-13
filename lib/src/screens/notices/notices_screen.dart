import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/notices/notices_controller.dart';
import 'package:segundo_parcial_movil_sw1/src/models/notice.dart';

class NoticesScreen extends StatelessWidget {
  final int id;
  final NoticesController controller = Get.put(NoticesController());

  NoticesScreen({required this.id});

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Fetch notices when the screen is built
    controller.fetchNotices(id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 70, 40),
        title: const Text(
          'Noticias',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: startDateController,
                      decoration: InputDecoration(
                        labelText: 'Desde',
                        hintText: 'YYYY-MM-DD',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          startDateController.text = formattedDate;
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: endDateController,
                      decoration: InputDecoration(
                        labelText: 'Hasta',
                        hintText: 'YYYY-MM-DD',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          endDateController.text = formattedDate;
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (startDateController.text.isNotEmpty &&
                            endDateController.text.isNotEmpty) {
                          DateTime startDate = DateFormat('yyyy-MM-dd')
                              .parse(startDateController.text);
                          DateTime endDate =
                              DateFormat('yyyy-MM-dd').parse(endDateController.text);
                          controller.filterNotices(startDate, endDate);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 45, 70, 40),
                      ),
                      child: const Text('Buscar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        startDateController.clear();
                        endDateController.clear();
                        controller.filteredNotices.value = controller.notices;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 92, 92, 92),
                      ),
                      child: const Text('Limpiar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.filteredNotices.isEmpty) {
                    return const Center(child: Text('No hay noticias disponibles'));
                  }

                  return ListView.builder(
                    itemCount: controller.filteredNotices.length,
                    itemBuilder: (context, index) {
                      Notice notice = controller.filteredNotices[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notice.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(notice.description),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Fecha Inicio: ${notice.fechaInicio != null ? "${notice.fechaInicio!.day.toString().padLeft(2, '0')}-${notice.fechaInicio!.month.toString().padLeft(2, '0')}-${notice.fechaInicio!.year}" : "N/A"}'),
                                  Text(
                                      'Fecha Fin: ${notice.fechaFin != null ? "${notice.fechaFin!.day.toString().padLeft(2, '0')}-${notice.fechaFin!.month.toString().padLeft(2, '0')}-${notice.fechaFin!.year}" : "N/A"}'),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text('Curso: ${notice.curso ?? "N/A"}'),
                              Text('Materia: ${notice.materia ?? "N/A"}'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
