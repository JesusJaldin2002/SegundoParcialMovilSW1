import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:segundo_parcial_movil_sw1/src/models/attendance_list.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/attendance_list/attendance_list_controller.dart';

class AttendanceListScreen extends StatelessWidget {
  final int id;

  const AttendanceListScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final AttendanceListController controller = Get.put(AttendanceListController());
    controller.setCursoId(id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 70, 40),
        title: const Text(
          'Lista de Asistencias',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              controller.createAttendanceList(id);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                controller.createAttendanceList(id);
              },
              icon: const Icon(Icons.add),
              label: const Text('Crear Lista de Asistencia'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 45, 70, 40),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.message.isNotEmpty) {
                  return Center(child: Text(controller.message.value));
                }

                // Ordenar las listas por fecha, más recientes primero
                var sortedLists = controller.attendanceLists.toList();
                sortedLists.sort((a, b) => b.fecha.compareTo(a.fecha));

                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: sortedLists.length,
                  itemBuilder: (context, index) {
                    AttendanceList attendanceList = sortedLists[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        title: Text(
                          DateFormat('dd \'de\' MMMM \'del\' yyyy', 'es_ES').format(attendanceList.fecha),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14, // Ajuste del tamaño de la fuente
                          ),
                        ),
                        subtitle: Text(
                          attendanceList.cursoName,
                          style: const TextStyle(
                            fontSize: 12, // Ajuste del tamaño de la fuente
                            color: Colors.grey,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromARGB(255, 45, 70, 40),
                        ),
                        onTap: () {
                          // Navegar a la pantalla de detalles de la lista de asistencia
                          // Enviar el id de la lista de asistencia y el curso_id como argumentos
                          Get.toNamed('/inscribed-students', arguments: {
                            'attendanceListId': attendanceList.id,
                            'cursoId': attendanceList.cursoId
                          });
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
