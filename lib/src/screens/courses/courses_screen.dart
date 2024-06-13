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
          itemCount: controller.courses.length,
          itemBuilder: (context, index) {
            Curso course = controller.courses[index];
            return ListTile(
              title: Text(course.cursoName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.materiaName),
                  Text('Horario: ${course.schedule}'),
                  Text('Aula: ${course.aulaName}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () => _onViewNoticesTap(context, course),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _onCreateNoticeTap(context, course),
                  ),
                ],
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
