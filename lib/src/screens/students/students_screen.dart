// screens/students_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/models/student.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/students/students_controller.dart';

class StudentsScreen extends StatelessWidget {
  final int id;
  final StudentsController controller = Get.put(StudentsController());

  StudentsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // Fetch students when the screen is built
    controller.fetchStudents(id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 70, 40),
        title: const Text(
          'Estudiantes',
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
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.students.isEmpty) {
                    return const Center(
                        child: Text('No hay estudiantes disponibles'));
                  }

                  return ListView.builder(
                    itemCount: controller.students.length,
                    itemBuilder: (context, index) {
                      Student student = controller.students[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                            student.studentName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text('Curso: ${student.courseName}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.event),
                                onPressed: () {
                                  Get.toNamed('/events/${student.userId}');
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.book),
                                onPressed: () {
                                  Get.toNamed('/boletin/${student.userId}');
                                },
                              ),
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
