import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:segundo_parcial_movil_sw1/src/models/notice.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/events/events_controller.dart';

class EventsScreen extends StatelessWidget {
  final int id;
  final EventsController controller = Get.put(EventsController());

  EventsScreen({super.key, required this.id});

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Fetch events when the screen is built
    controller.fetchEvents(id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 70, 40),
        title: const Text(
          'Eventos',
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
                        prefixIcon: const Icon(Icons.calendar_today),
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
                        prefixIcon: const Icon(Icons.calendar_today),
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
                          controller.filterEvents(startDate, endDate);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 45, 70, 40),
                      ),
                      child: const Text('Buscar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        startDateController.clear();
                        endDateController.clear();
                        controller.filteredEvents.value = controller.events;
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

                  if (controller.filteredEvents.isEmpty) {
                    return const Center(child: Text('No hay eventos disponibles'));
                  }

                  return ListView.builder(
                    itemCount: controller.filteredEvents.length,
                    itemBuilder: (context, index) {
                      Notice event = controller.filteredEvents[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(event.description),
                              const SizedBox(height: 10),
                              Text(
                                'Fecha Inicio: ${event.fechaInicio != null ? "${event.fechaInicio!.day.toString().padLeft(2, '0')}-${event.fechaInicio!.month.toString().padLeft(2, '0')}-${event.fechaInicio!.year}" : "N/A"}',
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Fecha Presentación: ${event.fechaFin != null ? "${event.fechaFin!.day.toString().padLeft(2, '0')}-${event.fechaFin!.month.toString().padLeft(2, '0')}-${event.fechaFin!.year}" : "N/A"}',
                              style: const TextStyle(color: Color.fromARGB(255, 235, 112, 103), fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5),
                              Text('Curso: ${event.curso ?? "N/A"}'),
                              Text('Materia: ${event.materia ?? "N/A"}'),
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
