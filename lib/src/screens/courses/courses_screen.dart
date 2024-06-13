import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/courses/courses_controller.dart';
import 'package:segundo_parcial_movil_sw1/src/models/courses.dart'; // Asegúrate de que el path es correcto

class CoursesScreen extends StatelessWidget {
  final CoursesController controller = Get.put(CoursesController());

  CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 70, 40),
        title: const Text(
          'Cursos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.courses.isEmpty) {
          return const Center(child: Text('No courses available'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: controller.courses.length,
          itemBuilder: (context, index) {
            Curso course = controller.courses[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  course.cursoName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      course.materiaName,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 20, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text('Horario: ${course.schedule}'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 20, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text('Aula: ${course.aulaName}'),
                      ],
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.visibility, color: Color.fromARGB(255, 45, 70, 40)),
                      onPressed: () => _onViewNoticesTap(context, course),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Color.fromARGB(255, 45, 70, 40)),
                      onPressed: () => _onCreateNoticeTap(context, course),
                    ),
                  ],
                ),
                onTap: () => _onViewNoticesTap(context, course),
              ),
            );
          },
        );
      }),
    );
  }

  void _onViewNoticesTap(BuildContext context, Curso course) {
    // Navegar a la pantalla para ver avisos
    Get.toNamed('/notices/${course.cursoMateriaId}');
  }

  void _onCreateNoticeTap(BuildContext context, Curso course) {
    // Navegar a la pantalla para crear avisos con el curso_materia_id correspondiente
    Get.toNamed('/create-notice/${course.cursoMateriaId}');
  }
}
