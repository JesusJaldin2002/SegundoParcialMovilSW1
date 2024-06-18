// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/models/student_inscribed.dart';
import 'package:segundo_parcial_movil_sw1/src/providers/attendance_list_provider.dart';

class AttendanceDetailScreen extends StatelessWidget {
  final StudentInscribed student;
  final int attendanceListId;

  AttendanceDetailScreen({super.key})
      : student = Get.arguments['student'],
        attendanceListId = Get.arguments['attendanceListId'];

  final TextEditingController observationController = TextEditingController();
  final AttendanceListProvider provider = AttendanceListProvider();
  var estado = 'Presente'.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 45, 70, 40),
          title: const Text(
            'Detalle de Asistencia',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Estudiante: ${student.name}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: observationController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Observación',
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 45, 70, 40),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 45, 70, 40),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 45, 70, 40),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Estado:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Obx(() => Column(
                      children: [
                        RadioListTile(
                          title: const Text('Presente'),
                          value: 'Presente',
                          groupValue: estado.value,
                          activeColor: const Color.fromARGB(255, 45, 70, 40),
                          onChanged: (value) {
                            estado.value = value.toString();
                          },
                        ),
                        RadioListTile(
                          title: const Text('Falta'),
                          value: 'Ausente',
                          groupValue: estado.value,
                          activeColor: const Color.fromARGB(255, 45, 70, 40),
                          onChanged: (value) {
                            estado.value = value.toString();
                          },
                        ),
                        RadioListTile(
                          title: const Text('Tarde'),
                          value: 'Tarde',
                          groupValue: estado.value,
                          activeColor: const Color.fromARGB(255, 45, 70, 40),
                          onChanged: (value) {
                            estado.value = value.toString();
                          },
                        ),
                      ],
                    )),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        var result = await provider.saveAttendance(
                          attendanceListId,
                          student.id,
                          estado.value,
                          observationController.text,
                        );
                        if (result != null && result['success'] == true) {
                          Get.back();
                          Get.snackbar('Success', 'Asistencia guardada con éxito');
                        } else {
                          Get.snackbar('Error', result?['message'] ?? 'Error al guardar la asistencia');
                        }
                      } catch (e) {
                        Get.snackbar('Error', 'Error al guardar la asistencia');
                      }
                    },
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
                    child: const Text('Guardar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
