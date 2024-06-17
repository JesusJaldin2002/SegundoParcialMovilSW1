// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/providers/users_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UsersProvider usersProvider = UsersProvider();

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (isValidForm(email, password)) {
      Response response = await usersProvider.login(email, password, fcmToken);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody;
        if (response.body is String) {
          responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        } else {
          responseBody = response.body as Map<String, dynamic>;
        }

        if (responseBody.containsKey('error')) {
          Get.snackbar(
            'Error de Login',
            responseBody['error'],
            backgroundColor: const Color.fromARGB(255, 233, 93, 0),
            colorText: Colors.white,
          );
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', responseBody['token']);
          await prefs.setString('user_id', responseBody['user_id'].toString());
          await prefs.setString('model_name', responseBody['model_name']);
          await prefs.setString('user_name', responseBody['user_name']);

          String? savedToken = prefs.getString('user_name');
          print('Modelo guardado: $savedToken');
          Get.toNamed('/home');
        }
      } else {
        Get.snackbar(
          'Error de Login',
          'Por favor vuelve a intentarlo',
          backgroundColor: const Color.fromARGB(255, 233, 93, 0),
          colorText: Colors.white,
        );
      }
    }
  }

  bool isValidForm(String email, String password) {
    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Email no válido',
        'Por favor ingrese un email válido',
        backgroundColor: const Color.fromARGB(255, 233, 93, 0),
        colorText: Colors.white,
      );
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar(
        'Formulario no válido',
        'Por favor ingrese todos los campos',
        backgroundColor: const Color.fromARGB(255, 233, 93, 0),
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }
}
