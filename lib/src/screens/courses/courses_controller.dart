import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/providers/courses_provider.dart';
import 'package:segundo_parcial_movil_sw1/src/models/courses.dart'; // Asegúrate de que el path es correcto
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class CoursesController extends GetxController {
  CoursesProvider coursesProvider = CoursesProvider();
  var courses = <Curso>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdString = prefs.getString('user_id');

    if (userIdString != null) {
      int userId = int.parse(userIdString);
      Response response = await coursesProvider.getOfferts(userId);

      if (response.statusCode == 200) {
        var responseBody = response.body;
        try {
          Courses coursesData = coursesFromJson(responseBody);
          List<Curso> sortedCourses = coursesData.cursos;
          sortedCourses.sort((a, b) => a.cursoName.compareTo(b.cursoName));
          courses.value = sortedCourses;
        } catch (e) {
          Get.snackbar('Error', 'Failed to parse courses data',
              backgroundColor: const Color.fromARGB(255, 233, 93, 0),
              colorText: Colors.white);
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch courses',
            backgroundColor: const Color.fromARGB(255, 233, 93, 0),
            colorText: Colors.white);
      }
    } else {
      Get.snackbar('Error', 'User ID not found',
          backgroundColor: const Color.fromARGB(255, 233, 93, 0),
          colorText: Colors.white);
    }

    isLoading.value = false;
  }
}