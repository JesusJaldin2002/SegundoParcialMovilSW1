import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/inscribed_students/inscribed_students_controller.dart';
import 'package:segundo_parcial_movil_sw1/src/models/student_inscribed.dart';

class InscribedStudentsScreen extends StatelessWidget {
  final int attendanceListId;
  final int cursoId;

  InscribedStudentsScreen({super.key})
      : attendanceListId = Get.arguments['attendanceListId'],
        cursoId = Get.arguments['cursoId'];

  @override
  Widget build(BuildContext context) {
    final InscribedStudentsController controller = Get.put(InscribedStudentsController());
    controller.fetchInscribedStudents(cursoId);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 70, 40),
        title: const Text(
          'Estudiantes Inscritos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'ID Lista de Asistencia: $attendanceListId',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

                // Ordenar los estudiantes por nombre
                var sortedStudents = controller.students.toList();
                sortedStudents.sort((a, b) => a.name.compareTo(b.name));

                return ListView.builder(
                  itemCount: sortedStudents.length,
                  itemBuilder: (context, index) {
                    StudentInscribed student = sortedStudents[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color.fromARGB(255, 45, 70, 40),
                          child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          student.name,
                          style: const TextStyle(fontWeight: FontWeight.w400),
                        ),
                        onTap: () {
                          Get.toNamed('/attendance-detail', arguments: {
                            'student': student,
                            'attendanceListId': attendanceListId,
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
