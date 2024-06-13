import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:segundo_parcial_movil_sw1/src/config/environment/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersProvider extends GetConnect {
  String url = Environment.apiUrl;

  Future<Response> login(String email, String password) async {
    Response response = await post(
        '$url/api/login', {'email': email, 'password': password},
        headers: {'Content-Type': 'application/json'});

    return response;
  }

  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('user_name');

    if (userName != null) {
      return userName;
    }

    return 'Usuario desconocido';
  }

  Future<void> logout() async {
    // Obtener una instancia de SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Obtener el token JWT almacenado
    String? token = prefs.getString('token');

    if (token != null) {
      // Llamar a la API para cerrar la sesión
      await post(
        '$url/api/logout',
        {},
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Eliminar el token de SharedPreferences
      await prefs.remove('token');

      // Mostrar un mensaje de confirmación
      Get.snackbar('Sesión cerrada', 'Has cerrado sesión exitosamente',
          backgroundColor: const Color.fromARGB(255, 0, 56, 2),
          colorText: const Color.fromARGB(255, 255, 255, 255),
          duration: const Duration(seconds: 1));

      // Redirigir al usuario a la página de login
      Get.offAllNamed('/login');
    }
  }
}
